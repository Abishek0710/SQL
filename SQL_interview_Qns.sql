select * from orders limit 10;


#  Given a table of orders with customer_id, order_date, and amount, write a query to find customers who made more than one purchase in the same month

SELECT 
    customer_id,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS num_orders
FROM orders
GROUP BY customer_id, YEAR(order_date), MONTH(order_date)
HAVING COUNT(*) > 1
order by customer_id, order_month;


