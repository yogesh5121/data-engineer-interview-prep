Employees
| emp_id | emp_name | dept_id | salary | hire_date  |
| ------ | -------- | ------- | ------ | ---------- |
| 101    | Alice    | 10      | 50000  | 2022-01-10 |
| 102    | Bob      | 20      | 70000  | 2021-06-15 |
| 103    | Charlie  | 20      | 65000  | 2022-08-20 |
| 104    | David    | 30      | 90000  | 2020-11-05 |
| 105    | Eva      | 30      | 85000  | 2021-03-18 |
| 106    | Frank    | 10      | 55000  | 2023-01-25 |
| 107    | Grace    | 20      | 95000  | 2019-09-30 |

Department

| dept_id | dept_name |
| ------- | --------- |
| 10      | HR        |
| 20      | IT        |
| 30      | Finance   |
| 40      | Marketing |


1.Find departments having more than 2 employees.


  SELECT count(e.emp_id) AS employee_count, d.dept_name
  FROM Employee as e
  INNER JOIN Department as d
  ON e.dept_id = d.dept_id
  GROUP BY d.dept_id
  HAVING COUNT(e.emp_id) > 2
  



Expected Output:

| dept_name | employee_count |


2.Find the second highest salary in each department.
  
  WITH SECOND AS
  (
    SELECT e.emp_name, e.salary,d.dept_name, DENSE_RANK()OVER( PARTTION BY e.dept_id ORDER BY salary DESC) as rn
	FROM Employees as e
	JOIN Department as d
	ON e.dept_id = d.dept_id
   )
   SELECT salary
   FROM SECOND
   WHERE rn = 2


3.Find employees earning more than the average salary of their department.
  
  WITH avgsalary AS
  (
    SELECT  emp_name,salary,AVG(salary) OVER (PARTITON BY dept_id )as avgsalarydept
	FROM employees
	)
	
   SELECT emp_name
   FROM  avgsalary
   WHERE salary > avgsalarydept
  

4.For every department return:

   Highest Salary
   Lowest Salary
   Average Salary
   Total Salary
   Employee Count

Include departments with no employees.

SELECT MAX(salary),
       MIN(salary),
	   AVG(salary),
	   SUM(salary),
	   COUNT(emp_id),
	   dept_id
FROM Department
LEFT JOIN Employee
ON e.dept_id = d.dept_id
GROUP BY dept_id
