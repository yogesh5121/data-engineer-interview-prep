#Day 4


#Customers
  
| customer_id | customer_name | city      |
| ----------- | ------------- | --------- |
| 1           | Alice         | Chennai   |
| 2           | Bob           | Bangalore |
| 3           | Charlie       | Hyderabad |
| 4           | David         | Mumbai    |
| 5           | Eva           | Delhi     |

#Orders

| order_id | customer_id | order_date | amount |
| -------- | ----------- | ---------- | ------ |
| 101      | 1           | 2026-01-01 | 200    |
| 102      | 1           | 2026-01-05 | 350    |
| 103      | 2           | 2026-01-03 | 500    |
| 104      | 2           | 2026-01-10 | 600    |
| 105      | 2           | 2026-01-20 | 700    |
| 106      | 3           | 2026-01-02 | 150    |
| 107      | 3           | 2026-01-12 | 400    |
| 108      | 5           | 2026-01-15 | 800    |


#1.Find customers who placed more than one order.

 SELECT customer_id 
 FROM orders
 GROUP BY customer_id
 HAVING count(*) > 1
 WITH moreone AS
 (
 SELECT customer_id, ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date) as rn
 FROM Orders
 )
 SELECT customer_id
 FROM moreone
 WHERE rn > 1
 
 



#2.Find the top spending customer.

Return:

customer_id
customer_name
total_spending

SELECT c.customer_id, c.customer_name, SUM(o.amount) as total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY SUM(o.amount) desc;


#3.For every customer calculate:

Total Orders
Total Spending
Maximum Order Amount
Minimum Order Amount

SELECT 
       COUNT(order_id) AS Total_Orders, 
       SUM(amount) AS Total_Spending , 
	   MAX(amount) AS MAX_Order_Amt , 
	   MIN(amount) AS MIN_Order_Amt
FROM Orders
GROUP BY customer_id




#4.Find customers who made consecutive purchases.

WITH cte AS
(
SELECT *,
LAG(order_date)
OVER(PARTITION BY customer_id
ORDER BY order_date) prev_date
FROM Orders
)

SELECT *
FROM cte
WHERE DATEDIFF(day,prev_date,order_date)=1;

#5.Find customers whose total spending is greater than the average customer spending.

   WITH avgspending AS
   (
     SELECT AVG(amount) as Avgspending
	 FROM Orders
	),
	totalspending AS
	(
	 SELECT customer_id,SUM(amount) as totalamount
	 FROM orders
	 GROUP BY customer_id
	 )
	SELECT customer_id 
	FROM totalspending
	WHERE totalamount > ( SELECT * FROM Avgspending)
