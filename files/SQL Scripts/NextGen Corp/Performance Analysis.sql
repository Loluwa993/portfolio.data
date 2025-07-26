-- SQL CAPTONE PROJECT: NextGen Corp
-- "PERFORMANCE ANALYSIS"

/* GOAL: Evaluate employee performance across different departments and identify areas
where performance can be improved.*/

---
-- Q1: How many employees has left the company?
-- Q1 QUERY START
SELECT
	COUNT(DISTINCT t.employee_id) as Exit_Count
FROM turnover t
-- Q1 QUERY END


-- Q1.2 QUERY START
-- Returning Number Exits per Year
SELECT
	EXTRACT(YEAR FROM turnover_date) AS Exit_Year,
	COUNT(DISTINCT t.employee_id) as Exit_Count
FROM turnover t
GROUP BY Exit_Year
-- Q1.2 QUERY END



-- Average Performance for the Company
SELECT 
ROUND(AVG(performance_score),2)
AS Avg_Emp_Performance
FROM performance


---
--Q2: How many employees have a performance score of 5.0 / below 3.5?
---
--Q2 QUERY START
WITH
-- Returns a status list
	perf_status AS (
	SELECT 
		employee_id, department_id, 
		CASE
			WHEN performance_score = 5.0 THEN '5.0'
			WHEN performance_score < 3.5 THEN 'BELOW 3.5'
			ELSE '3.5+'
		END AS performance_score_status
	FROM performance
)

SELECT
	pfs.performance_score_status, 
	COUNT(DISTINCT pfs.employee_id) AS Employee_Count	
FROM perf_status pfs
WHERE pfs.performance_score_status NOT LIKE '3.5+'
GROUP BY 
	pfs.performance_score_status
--Q2 QUERY END


--
--Number of Employees per Department
SELECT
	d.department_name, COUNT(DISTINCT p.employee_id) AS Empl_Count
FROM performance p
LEFT JOIN department d ON d.department_id = p.department_id
GROUP BY d.department_name
ORDER BY Empl_Count DESC


---
-- Q3: Which department has the most employees with a performance of 5.0 / below 3.5?
--
--Q3 QUERY START
WITH
-- Returns a status list
	perf_status AS (
	SELECT 
		employee_id, department_id, performance_score,
		CASE
			WHEN performance_score = 5.0 THEN '5.0'
			WHEN performance_score < 3.5 THEN 'BELOW 3.5'
			ELSE '3.5+'
		END AS performance_score_status
	FROM performance
)

SELECT
	d.department_name, 
	COUNT(pfs.employee_id) AS Employee_Count	
FROM department d
LEFT JOIN 
	perf_status pfs ON pfs.department_id = d.department_id
WHERE
	pfs.performance_score = 5.0	 OR pfs.performance_score < 3.5
GROUP BY 
	d.department_name
ORDER BY
	Employee_Count DESC
--Q3 QUERY END



---
--Q4: What is the average performance score by department?
-- Q4 QUERY START
SELECT
	d.department_name, ROUND(AVG(p.performance_score),2) as AVG_pScore
FROM department d
LEFT JOIN 
	performance p ON p.department_id = d.department_id
GROUP BY
	d.department_name
ORDER BY
	AVG_pScore DESC
-- Q4 QUERY END
