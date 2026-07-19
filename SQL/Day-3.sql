#Day 3


#orders
| order_id | customer_id | product_id | order_date | amount |
| -------- | ----------- | ---------- | ---------- | ------ |
| 101      | 1           | P1         | 2026-01-01 | 500    |
| 102      | 1           | P2         | 2026-01-03 | 800    |
| 103      | 2           | P1         | 2026-01-04 | 300    |
| 104      | 2           | P3         | 2026-01-05 | 700    |
| 105      | 3           | P2         | 2026-01-07 | 900    |
| 106      | 1           | P3         | 2026-01-10 | 400    |
| 107      | 4           | P1         | 2026-01-12 | 600    |


#customers


| customer_id | customer_name | city      |
| ----------- | ------------- | --------- |
| 1           | Alice         | Bangalore |
| 2           | Bob           | Chennai   |
| 3           | Charlie       | Hyderabad |
| 4           | David         | Mumbai    |
| 5           | Eva           | Delhi     |

#Q1 (Easy)

#Find customers who have never placed an order.

SELECT customer_name
FROM customers c
LEFT JOIN  orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL

#Q2 (Medium)

#Find each customer's latest order.

WITH latest_order AS
(
  SELECT customer_id,order_id, order_date ,amount, ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date DESC) as rn
  FROM orders
 )
 SELECT customer_id,order_id ,order_date , amount 
 FROM latest_order
 WHERE rn = 1;

Expected Output

| customer_id | order_id | order_date | amount |

#Q3 (Medium)

#Find the second highest order amount.

WITH second as
(
  SELECT amount, DENSE_RANK()OVER(ORDER BY Amount DESC) as rnk
  FROM orders
)

SELECT amount
FROM Orders
WHERE rnk = 2

#Q4 (Medium-Hard)

#Find customers whose total purchase amount is greater than the overall average customer spending.

WITH AVG_cust AS 
(
  SELECT AVG(amount) as avgspending
  FROM Orders
  ),
  
Total_amount as
(
 SELECT customer_id,SUM(amount) as TOTALamount
 FROM Orders
 GROUP BY customer_id
)

SELECT customer_id
FROM Total_amount
WHERE Totalamount > (SELECT AVG(amount) as avgspending
  FROM Orders);
