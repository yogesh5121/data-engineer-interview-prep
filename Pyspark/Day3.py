Day 3


orders
| order_id | customer_id | product_id | order_date | amount |
| -------- | ----------- | ---------- | ---------- | ------ |
| 101      | 1           | P1         | 2026-01-01 | 500    |
| 102      | 1           | P2         | 2026-01-03 | 800    |
| 103      | 2           | P1         | 2026-01-04 | 300    |
| 104      | 2           | P3         | 2026-01-05 | 700    |
| 105      | 3           | P2         | 2026-01-07 | 900    |
| 106      | 1           | P3         | 2026-01-10 | 400    |
| 107      | 4           | P1         | 2026-01-12 | 600    |


customers


| customer_id | customer_name | city      |
| ----------- | ------------- | --------- |
| 1           | Alice         | Bangalore |
| 2           | Bob           | Chennai   |
| 3           | Charlie       | Hyderabad |
| 4           | David         | Mumbai    |
| 5           | Eva           | Delhi     |


orders_df
customers_df
Q1

Find customers without orders using Left Anti Join.

without_order_df = customers_df.join(
    orders_df,
    on="customer_id",
    how="left_anti"
)

Q2

Find the latest order for every customer using a Window Function.

w = window.partionBy("customer_id").orderBy(desc("order_date"))

latest_df = orders_df.withColumn("rn", row_number().over(w)).filter(rn == 1)

Q3

Calculate customer-wise:

Total Orders
Total Amount
Average Amount

customer_anlys_df = orders_df.groupBy("customer_id").agg( count("order_id").alias("Total_Orders"),sum("amount").alias("Total_Amount"), avg("amount").alias("Average_Amount"))

Q4

Remove duplicate orders based on order_id.

(This is directly covered in your interview material.)

w = window.partitionBy(order_id).orderBy(order_date)


result_df = orders_df.withColumn("rn", row_number().over(w)).filter(rn == 1).drop(rn)

Q5

Write PySpark code to perform an incremental load from a Delta table using a last_updated timestamp and merge the new data into the target table.

MERGE INTO employee_target t
USING employee_staging s
ON t.emp_id = s.emp_id

WHEN MATCHED
AND s.last_updated > t.last_updated
THEN UPDATE SET
    t.name = s.name,
    t.salary = s.salary,
    t.last_updated = s.last_updated

WHEN NOT MATCHED THEN
INSERT (
    emp_id,
    name,
    salary,
    last_updated
)
VALUES (
    s.emp_id,
    s.name,
    s.salary,
    s.last_updated
);


target.alias("t")
.merge(
    source.alias("s"),
    "t.order_id = s.order_id"
)
.whenMatchedUpdate(
    condition="s.last_updated > t.last_updated",
    set={
        "amount":"s.amount",
        "customer_id":"s.customer_id",
        "last_updated":"s.last_updated"
    }
)
.whenNotMatchedInsertAll()
.execute()
