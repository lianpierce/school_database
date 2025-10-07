-- 1.1
SELECT CONCAT(first_name, ' ', last_name) AS full_name, department, salary
FROM employees;

-- 1.2
SELECT DISTINCT department
FROM employees;

-- 1.3
SELECT project_name, budget,
    CASE
        WHEN budget > 150000 THEN 'Large'
        WHEN budget BETWEEN 100000 AND 150000 THEN 'Medium'
        ELSE 'Small'
    END AS budget_category
FROM projects;

-- 1.4
SELECT CONCAT(first_name, ' ', last_name) AS full_name, COALESCE(email, 'No email provided') AS email
FROM employees;

-- 2.1
SELECT *
FROM employees
WHERE hire_date > '2020-01-01';
    
-- 2.2
SELECT *
FROM employees
WHERE salary BETWEEN 60000 AND 70000;

-- 2.3
SELECT *
FROM employees
WHERE last_name LIKE '[SJ]%';

-- 2.4
SELECT *
FROM employees
WHERE manager_id IS NOT NULL AND department = 'IT';

-- 3.1
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS employee_name,
    LENGTH(last_name) AS last_name_length,
    SUBSTRING(email FROM 1 FOR 3) AS email_prefix
FROM employees;

-- 3.2
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
    salary AS annual_salary,
    ROUND(salary / 12, 2) AS monthly_salary,
    salary * 0.10 AS raise_amount
FROM employees;

-- 3.3
SELECT FORMAT('Project: %s - Budget: $%s - Status: %s', project_name, budget, status) AS project_details
FROM projects;

-- 3.4
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
    FLOOR(DATE_PART('year', AGE(CURRENT_DATE, hire_date))) AS years_of_service
FROM employees;

-- 4.1
SELECT department, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department;

-- 4.2
SELECT p.project_name, SUM(a.hours_worked) AS total_hours
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_name;

-- 4.3
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- 4.4
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary, SUM(salary) AS total_payroll
FROM employees;

-- 5.1
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary > 65000
UNION
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE hire_date > '2020-01-01';

-- 5.2
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE department = 'IT'
INTERSECT
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary > 65000;

-- 5.3
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
EXCEPT
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees e
JOIN assignments a ON e.employee_id = a.employee_id;

-- 6.1
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM assignments a
    WHERE a.employee_id = e.employee_id
);

-- 6.2
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees e
WHERE e.employee_id IN (
    SELECT a.employee_id
    FROM assignments a
    JOIN projects p ON a.project_id = p.project_id
    WHERE p.status = 'Active'
);

-- 6.3
SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Sales'
);

-- 7.1
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.department,
    COALESCE(AVG(a.hours_worked), 0) AS avg_hours_worked,
    RANK() OVER (PARTITION BY e.department ORDER BY e.salary DESC) AS salary_rank
FROM employees e
LEFT JOIN assignments a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.department, e.salary
ORDER BY e.department, salary_rank;

-- 7.2
SELECT p.project_name,
    SUM(a.hours_worked) AS total_hours,
    COUNT(DISTINCT a.employee_id) AS employee_count
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name
HAVING SUM(a.hours_worked) > 150;

-- 7.3
SELECT e.department,
    COUNT(*) AS total_employees,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    MAX(CONCAT(e.first_name, ' ', e.last_name)) KEEP (DENSE_RANK FIRST ORDER BY e.salary DESC) AS highest_paid
FROM employees e
GROUP BY e.department;