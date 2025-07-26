-- SQL CAPTONE PROJECT: NextGen Corp
-- "SALARY ANALYSIS"

-- GOAL: Analyze salary distribution and ensure fair compensation based on performance and departmental benchmarks.


-- Update the column name 'Depaartment_id' to 'Department_id'
/* EXECUTED!!
ALTER TABLE salary
RENAME COLUMN depaartment_id
TO department_id;
*/


---
-- Q1: What is the total salary expense for the company?
-- Q1 QUERY START
SELECT	
	TO_CHAR(
	SUM(salary_amount),'FM9,999,999') 
	AS "Total Salary Expense"
FROM salary
/*WHERE
	employee_id NOT IN
	(SELECT employee_id from turnover) 
	--This line considers the removal on employee in the turnover list from the calculation
*/
-- Q1 QUERY END



---
-- Q2: What is the average salary by job title?
-- Q2 QUERY START
SELECT
	e.job_title,
	ROUND(AVG(s.salary_amount),2) AS "Average Salary"
FROM salary s 
LEFT JOIN
	employee e ON s.employee_id = e.employee_id
GROUP BY
	e.job_title
ORDER BY
	"Average Salary" DESC
-- Q2 QUERY END


-- Average Salary for the Company
SELECT ROUND(AVG(salary_amount),2)
FROM salary



---
-- Q3: How many employees earn above 80,000?
-- Q3 QUERY START
SELECT
	COUNT(s.employee_id) AS "#_Above_80k_Earners"
FROM salary s
WHERE s.salary_amount > 80000
-- Q3 QUERY END


-- Q3.2 QUERY START
-- Employee count earning above overall average
SELECT
	COUNT(s.employee_id) AS "#_Above_Avg_Salary"
FROM salary s
WHERE s.salary_amount > 
		(SELECT ROUND(AVG(salary_amount),2)
		FROM salary)
-- Q3.2 QUERY END



---
-- Q4: How does performance correlate with salary across departments?
-- Q4 QUERY START

SELECT
	d.department_name, ROUND(AVG(p.performance_score),2) AS avg_score,
	ROUND(AVG(s.salary_amount),2) AS avg_salary
FROM department d
LEFT JOIN 
	performance p ON p.department_id = d.department_id
LEFT JOIN
	salary s ON s.department_id = d.department_id
-- WHERE s.employee_id NOT IN
--		(SELECT employee_id from turnover) -- This line considers the removal on employee in the turnover list from the calculation
GROUP BY
	d.department_name
ORDER BY
	avg_score

