#DAY 2 

## Employee

| emp_id | emp_name | department | salary | joining_date |
| ------ | -------- | ---------- | ------ | ------------ |
| 101    | Alice    | HR         | 50000  | 2022-01-10   |
| 102    | Bob      | IT         | 80000  | 2021-06-15   |
| 103    | Charlie  | IT         | 75000  | 2023-02-20   |
| 104    | David    | Finance    | 90000  | 2020-11-05   |
| 105    | Eva      | Finance    | 85000  | 2021-08-12   |
| 106    | Frank    | HR         | 55000  | 2022-07-18   |
| 107    | Grace    | IT         | 95000  | 2019-05-30   |

# Bonus

| emp_id | bonus |
| ------ | ----- |
| 101    | 5000  |
| 102    | 10000 |
| 104    | 15000 |
| 107    | 20000 |


#1.Find employees who did not receive a bonus.

   SELECT emp_name
   FROM employee
   WHERE emp_id 
   NOT IN ( SELECT emp_id FROM Bonus)


#2.Find the second highest salary in the company.

  WITH second AS
  (
    SELECT *, DENSE_RANK()OVER(ORDER BY salary DESC) as rn 
	FROM Employee
   )
   SELECT salary
   FROM second
   WHERE rn = 2
   
	

#3.Find the highest-paid employee in each department.

WITH Highest AS
(
  SELECT *, DENSE_RANK()OVER(PARTITON BY Department ORDER BY salary DESC) as rn 
  FROM Employee
)

SELECT department, emp_name , salary
FROM Highest
WHERE rn = 1

Expected Output:

| department | emp_name | salary |


#4.For every employee, display:

   Employee Name
   Salary
   Department Average Salary
Difference between Employee Salary and Department Average

Example:

|Employee|Salary|Dept Avg|Difference|


SELECT
   emp_name,
   salary, 
   AVG(salary) OVER ( PARTITON BY department ) as Dept_avg,
   salary - AVG(salary) OVER ( PARTITON BY department ) as Difference
FROM
Employee




#5.For each department calculate:

   Total Employees
   Highest Salary
   Lowest Salary
   Average Salary
   Total Salary Expense



SELECT 
   COUNT(emp_id) as Total Employees,
   MAX(salary) as Highest Salary,
   MIN(salary) as Lowest Salary,
   AVG(salary) as Average Salary,
   SUM(salary) AS Total Salary Expense
   
FROM Employee
GROUP BY department

#6.Find employees earning more than the average salary of their department.
	 
SELECT *
FROM
(
SELECT *,
AVG(salary) OVER(PARTITION BY department) avg_salary
FROM Employee
)t
WHERE salary>avg_salary;
