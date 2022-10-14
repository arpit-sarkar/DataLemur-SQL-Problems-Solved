/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Compensation Outliers
	   URL:		https://datalemur.com/questions/compensation-outliers

Your team at Accenture is helping a Fortune 500 client revamp their compensation and benefits program. The first step in this analysis is to manually review employees who are potentially overpaid or underpaid.

An employee is considered to be potentially overpaid if they earn more than 2 times the average salary for people with the same title. Similarly, an employee might be underpaid if they earn less than half of the average for their title. We'll refer to employees who are both underpaid and overpaid as compensation outliers for the purposes of this problem.

Write a query that shows the following data for each compensation outlier: employee ID, salary, and whether they are potentially overpaid or potentially underpaid (refer to Example Output below).

employee_pay Table:
Column Name	Type
employee_id	integer
salary	integer
title	varchar
employee_pay Example Input:
employee_id	salary	title
101	80000	Data Analyst
102	90000	Data Analyst
103	100000	Data Analyst
104	30000	Data Analyst
105	120000	Data Scientist
106	100000	Data Scientist
107	80000	Data Scientist
108	310000	Data Scientist
Example Output:
employee_id	salary	status
104	30000	Underpaid
108	310000	Overpaid
Explanation
In this example, 2 employees qualify as compensation outliers. Employee 104 is a Data Analyst, and the average salary for this position is $75,000. Meanwhile, the salary of employee 104 is less than $37,500 (half of $75,000); therefore, they are underpaid.

*********************************************************************************
*/

WITH CTE1 AS (
SELECT title, AVG(salary) AS avg_salary
FROM employee_pay
GROUP BY title
),

CTE2 AS (
SELECT employee_id, salary, avg_salary,
CASE WHEN salary>2*avg_salary THEN 'Overpaid'
     WHEN salary<0.5*avg_salary THEN 'Underpaid'
     ELSE NULL
     END AS status
FROM employee_pay E INNER JOIN CTE1
ON E.title=CTE1.title
)

SELECT employee_id, salary, status
FROM CTE2
WHERE status IS NOT NULL