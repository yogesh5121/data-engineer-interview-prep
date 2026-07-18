#DAY 2 

Employee

| emp_id | emp_name | department | salary | joining_date |
| ------ | -------- | ---------- | ------ | ------------ |
| 101    | Alice    | HR         | 50000  | 2022-01-10   |
| 102    | Bob      | IT         | 80000  | 2021-06-15   |
| 103    | Charlie  | IT         | 75000  | 2023-02-20   |
| 104    | David    | Finance    | 90000  | 2020-11-05   |
| 105    | Eva      | Finance    | 85000  | 2021-08-12   |
| 106    | Frank    | HR         | 55000  | 2022-07-18   |
| 107    | Grace    | IT         | 95000  | 2019-05-30   |

Bonus

| emp_id | bonus |
| ------ | ----- |
| 101    | 5000  |
| 102    | 10000 |
| 104    | 15000 |
| 107    | 20000 |


#Q1

#employee_df
#bonus_df

#Join employee and bonus tables.

join_df = employee_df.join(bonus_df , how = "inner" , on ="emp_id")

#Q2.Find employees without bonuses.


without_df = employee_df.join(bonus_df , how ="Left Anti",on ="emp_id")

(Hint: Left Anti Join)

#Q3.Calculate department-wise:

Employee Count
Total Salary
Average Salary

result_df = employee_df.groupBy("department").agg( count(emp_id).alias("Employee count"), sum("salary").alias("Total salary"), avg(salary).alias("Average salary"))


#Q4.find the highest-paid employee in each department.

w = window.partitionBy(department).orderBy(desc(salary))

result_df = employee_df.withColumn( "rn", dense_rank().over(w)).filter("rn" == 1)

# Q5.Find employees whose salary is greater than their department average.

w = Window.partitionBy("department")

employee_df \
.withColumn(
"dept_avg",
avg("salary").over(w)
)\
.filter(col("salary")>col("dept_avg"))
