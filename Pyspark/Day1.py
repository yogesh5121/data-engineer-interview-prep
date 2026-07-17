#Day-1

#customers
customer_id 	customer_name 	city
1	              Alice     	  Bangalore
2             	Bob	         Chennai
3         	   Charlie	     Hyderabad
4	             David       	Bangalore
5	              Eva	       Mumbai
orders
order_id	customer_id	order_date	amount
101	          1	        2026-01-10	500
102	          1	        2026-01-15	700
103		        2          2026-01-11	300
104	  	      2          2026-02-01	800
105		        2          2026-02-05	200
106		        3          2026-01-20	1000
107	          5	         2026-02-02	600


#Create DataFrames from the above tables.

# Q1.Join customers and orders.
Customer_df = spark.read.format("delta").load("customer_table")
Order_df = spark.read.format("delta").load("order_table")

join_df = Customer_df.join(Order_df , on ="customer_id" ,how ="inner")


# Q2.Calculate Total Orders Total Spend per customer.

total_df = join_df.groupBy("customer_id").agg( count("order_id").alais("Total_orders"),sum(amount).alais("Total_spend"))

#Q3.Find customers with no orders.

order_df = Customer_df.join(Order_df , on ="customer_id" , how ="left_anti").when(order_id = 'NULL')

(Hint: Left Anti Join)

# Q4.find each customer's latest order.

w = window.partitionBy("customer_id").orderBy(desc(order_date))

res-df = Order_df.withcolumn("rn", row_number().over(w)).filter(rn == 1)

# Q5.Find Top 2 highest spending customers.

total_df = order_df.groupBy("customer_id").agg(sum("amount").alais("total"))

w = window.orderBy(desc(total))

resdf = customer_df.withcolumn("rn", dense_rank().over(w)).filter(rn <=2)
