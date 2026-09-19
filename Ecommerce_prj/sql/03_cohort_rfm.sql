WITH customer_orders AS (
    -- Group orders by the unique customer persona
    SELECT 
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_spend
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_raw AS (
    SELECT 
        customer_unique_id,
        -- Reference date set to the dataset's latest recorded timestamp + 1 day
        DATE_PART('day', ('2018-09-04'::timestamp - last_purchase_date)) AS recency,
        total_orders AS frequency,
        total_spend AS monetary
    FROM customer_orders
),
rfm_scores AS (
    SELECT 
        customer_unique_id,
        recency,
        frequency,
        monetary,
        -- Divide into quartiles / score tiers using NTILE
        NTILE(4) OVER (ORDER BY recency DESC) AS r_score,  -- Higher score = bought more recently
        NTILE(4) OVER (ORDER BY monetary ASC) AS m_score   -- Higher score = spent more money
    FROM rfm_raw
),
customer_segments AS (
    SELECT 
        customer_unique_id,
        recency,
        frequency,
        monetary,
        r_score,
        m_score,
        CASE 
            WHEN r_score >= 3 AND m_score >= 3 THEN 'Champions / VIP'
            WHEN r_score >= 3 AND m_score < 3 THEN 'Potential Loyalists'
            WHEN r_score <= 2 AND m_score >= 3 THEN 'At Risk / High Value'
            ELSE 'Lost / Churned'
        END AS customer_segment
    FROM rfm_scores
)
-- Aggregate summary for business decision makers
SELECT 
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(recency)::numeric, 1) AS avg_days_since_last_order,
    ROUND(AVG(monetary)::numeric, 2) AS avg_spend,
    ROUND(SUM(monetary)::numeric, 2) AS total_segment_revenue
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_segment_revenue DESC;