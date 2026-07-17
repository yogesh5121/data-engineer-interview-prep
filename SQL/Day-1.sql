# Day 1

customers
customer_id	customer_name	 city
1	          Alice	         Bangalore
2	          Bob	           Chennai
3	          Charlie      	 Hyderabad
4	          David	         Bangalore
5         	Eva	           Mumbai
orders
order_id	customer_id	order_date	amount
101	       1	        2026-01-10	500
102	       1	        2026-01-15	700
103        2          2026-01-11	300
104	       2	        2026-02-01	800
105	       2	        2026-02-05	200
106	       3	        2026-01-20	1000
107	       5	        2026-02-02	600

## Q1.Find customers who never placed an order.

SELECT customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL


##Q2. Find the total amount spent by each customer.

SELECT SUM(o.amount) as total_amount, c.customer_name
FROM customers c
LEFT JOIN  Orders o 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name

Expected Output

|customer_name|total_amount|


## Q3.Find the top 2 customers based on total spending.

WITH total AS
(
  SELECT SUM(amount) as total_amount, customer_id
  FROM orders
  GROUP BY customer_id
),

topcustomer AS
(
  SELECT *, DENSE_RANK() OVER (ORDER BY total_amount DESC) as rn
  FROM total
 )
 SELECT customer_name, amount
 FROM topcustomer
 WHERE rn <= 2

##Q4 For every customer, calculate:

   # Total Orders
   # Total Amount
   # Average Amount
   # First Order Date
   #Last Order Date

## Q5.Return all customers, including those with no orders.


SELECT COUNT(o.order_id) as Total_orders, 
SUM(o.amount) as Total_amount,
AVG(o.amount) as Average_amount,
MIN(o.order_date) AS First Order date,
MAX(o.order_date) AS Last Order Date
FROM orders o
JOIN customer c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
