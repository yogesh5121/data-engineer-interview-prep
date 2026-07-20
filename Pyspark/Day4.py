#customers_df
#orders_df

#Q1.Find customers without orders.

(Use Left Anti Join.)

result_df = customers_df.join(orders_df, on ="customer_id", how = "Left Anti")


#Q2.Calculate customer-wise:

#Total Orders
#Total Spending
#Average Order Value

customer_ana_df = orders_df.groupBy("customer_id").agg(count("order_id").alais("Total_Orders"),sum("amount").alais("total_spending"),avg("amount").alais("average_order_value"))

#Q3

#Using a Window Function, find the latest order for every customer.

w = window.partitionBy("customer_id").orderBY(desc("order_date"))

df = orders_df.withColumn("rn", rownumber().over(w)).filter(rn == 1)

#Q4

#Find the top spending customer.

#(Use groupBy + Window Function.)

total_df = orders_df.groupBy("customer_id").agg( sum(amount).alais("total_amount"))

w = window.orderBy(col("total_amount").desc())

top_df = order_df.withColumn("rn", row_number().over(w)).filter(rn == 1)
