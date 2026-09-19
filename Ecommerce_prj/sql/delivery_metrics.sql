WITH delivery_metrics AS (
    SELECT 
        o.order_id,
        c.customer_state,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        -- Calculate difference in days between actual delivery and estimated delivery
        DATE_PART('day', o.order_delivered_customer_date - o.order_estimated_delivery_date) AS delay_days,
        CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 
            ELSE 0 
        END AS is_late
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
)
SELECT 
    customer_state,
    COUNT(order_id) AS total_delivered_orders,
    SUM(is_late) AS late_orders_count,
    ROUND((SUM(is_late)::NUMERIC / COUNT(order_id)) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(CASE WHEN is_late = 1 THEN delay_days ELSE NULL END)::NUMERIC, 1) AS avg_days_late
FROM delivery_metrics
GROUP BY customer_state
HAVING COUNT(order_id) > 100
ORDER BY late_delivery_rate_pct DESC
LIMIT 5;