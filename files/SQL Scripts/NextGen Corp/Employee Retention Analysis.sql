-- SQL CAPTONE PROJECT: NextGen Corp
-- "EMPLOYEE RETENTION ANALYSIS"

-- GOAL: Understand the employee turnover trends and identify the root causes of high turnover rates.


--
/*Q1: Who are the top 5 highest serving employees? */
-- Using 'hire_date' and sorting from first hire limit to top(5)

--Q1 QUERY START
SELECT
	e.employee_id, e.first_name,e.last_name, e.job_title, e.hire_date,
	AGE(CURRENT_DATE,e.hire_date) AS service_time
FROM employee e
/*WHERE
	employee_id NOT IN
	(SELECT employee_id from turnover) -- Removing Employees that left the company*/
ORDER BY hire_date ASC
LIMIT 5
-- Q1 QUERY END


-- Total Number of Employees
SELECT
	COUNT(DISTINCT employee_id) AS Employee_Count
FROM employee

-- Number of Employees (Remaining)
SELECT
	COUNT(DISTINCT employee_id) AS Employee_Count
FROM employee
WHERE
	employee_id NOT IN
	(SELECT employee_id FROM turnover)

--
/*Q2: What is the turnover rate for each department? */
-- COLUMNS: Department, Turnover_Rate = (employee that left / total employee)

--Q2 QUERY START
WITH 
-- Number of Employee per Department
	CountEmployees AS (
	SELECT
		e.department_id, d.department_name, COUNT(e.employee_id) AS Employees_Count
	FROM employee e
	RIGHT JOIN
		department d ON d.department_id = e.department_id
	GROUP BY
		e.department_id, d.department_name
),
-- Number of Turnover per Department
	CountTurnovers AS (
	SELECT
		t.department_id, d.department_name, COUNT(t.employee_id) AS Turnovers_Count
	FROM turnover t
	RIGHT JOIN
		department d ON d.department_id = t.department_id
	GROUP BY
		t.department_id, d.department_name
)
-- Employee Turnover Rate %
SELECT
	d.department_name, 
	COALESCE(ce.employees_count,0) AS "#Employees", 
	COALESCE(ct.turnovers_count,0) AS "#Turnovers",
	CASE
		WHEN COALESCE(ce.employees_count,0) = 0 THEN 0.00
		ELSE ROUND((CAST(COALESCE(ct.turnovers_count,0) AS DECIMAL)*100 / ce.employees_count),2)
	END AS Turnover_Rate_Pctge
FROM department d
LEFT JOIN 
	CountEmployees ce ON ce.department_id = d.department_id
LEFT JOIN 
	CountTurnovers ct ON ct.department_id = d.department_id
ORDER BY
	Turnover_Rate_Pctge DESC
-- Q2 QUERY END



--Company's Overall Turnover Rate %
WITH 
Exit_Count AS (SELECT COUNT(DISTINCT t.employee_id) AS no_exits
FROM turnover t),
Total_Count AS (SELECT COUNT(DISTINCT e.employee_id) AS all_count
FROM employee e)

SELECT ec.no_exits, tc.all_count,
 ROUND((ec.no_exits * 100 / tc.all_count),2) AS turn_rate
FROM Exit_Count ec, Total_Count tc



--
/*Q3: Which employees are at risk of leaving based on their performance?*/
-- Assuming that 3.5 is the benchmark performance_score
-- This second script considers evaluating the employees based on their recent performance score

-- Q3.V2 QUERY START
WITH
	-- There are multiple score per employee, hence considering the recent performance score
	recent_performance_score AS (
			WITH
			last_record_date AS (
				SELECT 
					employee_id,MAX(performance_date) AS last_date
				FROM performance
				GROUP BY
					employee_id
			)
			SELECT 
				p.employee_id, p.department_id , p.performance_score,
				lrd.last_date
			FROM performance p
			LEFT JOIN last_record_date lrd ON
					lrd.employee_id = p.employee_id
			WHERE performance_date = lrd.last_date
			GROUP BY 
				p.employee_id,p.department_id,p.performance_score,lrd.last_date
		)
	
SELECT 
	rps.employee_id,e.first_name,e.last_name,e.job_title,
	d.department_name,rps.performance_score
FROM recent_performance_score rps
LEFT JOIN 
	employee e ON rps.employee_id = e.employee_id
LEFT JOIN 
	department d ON d.department_id = rps.department_id
WHERE
	rps.employee_id NOT IN (SELECT employee_id from turnover) --Exempting employee in turnover table
	AND 
	rps.performance_score < 3.5
	-- The query block below considers using overall performance average as benchmark
	/*OR rps.performance_score < (SELECT AVG(performance_score) AS overall_avg
							FROM performance)*/
ORDER BY 
	rps.performance_score asc;
-- Q3.V2 QUERY END



--
/* Q4: What are the main reasons employees are leaving the company?*/
-- SELECT * FROM turnover

-- Q4 QUERY START
SELECT 
	DISTINCT reason_for_leaving as Reason, COUNT(employee_id) as Employee_Count
FROM turnover
GROUP BY 
	Reason
ORDER BY 
	Employee_Count desc
-- Q4 QUERY END

-- Good exit interview for staff leaving