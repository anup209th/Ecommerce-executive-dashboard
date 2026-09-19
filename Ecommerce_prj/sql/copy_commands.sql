TRUNCATE TABLE customers;
COPY customers (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM 'C:/Data_Analyst/Ecommerce/archive/olist_customers_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 1. Load Orders
TRUNCATE TABLE orders;
TRUNCATE TABLE order_items;
TRUNCATE TABLE order_payments;
COPY orders (
    order_id, 
    customer_id, 
    order_status, 
    order_purchase_timestamp, 
    order_approved_at, 
    order_delivered_carrier_date, 
    order_delivered_customer_date, 
    order_estimated_delivery_date
)
FROM 'C:/Data_Analyst/Ecommerce/archive/olist_orders_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 2. Load Order Items
COPY order_items (
    order_id, 
    order_item_id, 
    product_id, 
    seller_id, 
    shipping_limit_date, 
    price, 
    freight_value
)
FROM 'C:/Data_Analyst/Ecommerce/archive/olist_order_items_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 3. Load Order Payments
COPY order_payments (
    order_id, 
    payment_sequential, 
    payment_type, 
    payment_installments, 
    payment_value
)
FROM 'C:/Data_Analyst/Ecommerce/archive/olist_order_payments_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');