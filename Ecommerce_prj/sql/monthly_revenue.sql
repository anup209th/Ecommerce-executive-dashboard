WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(p.payment_value), 2) AS current_month_gmv
    FROM orders o
    JOIN order_payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
),
growth_calc AS (
    SELECT 
        order_month,
        total_orders,
        current_month_gmv,
        -- LAG() pulls the previous month's GMV to compute growth
        LAG(current_month_gmv, 1) OVER (ORDER BY order_month) AS prev_month_gmv
    FROM monthly_revenue
)
SELECT 
    order_month,
    total_orders,
    current_month_gmv,
    prev_month_gmv,
    ROUND(
        ((current_month_gmv - prev_month_gmv) / prev_month_gmv) * 100, 
        2
    ) AS mom_growth_pct
FROM growth_calc
ORDER BY order_month;