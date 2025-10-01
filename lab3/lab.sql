CREATE DATABASE lab;

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50) DEFAULT NULL,
    salary INT DEFAULT 40000,
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50),
    budget INT,
    manager_id INT
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name  VARCHAR(100), 
    dept_id INT,
    start_date DATE,
    end_date DATE,
    budget INT
)

-- PART B

INSERT INTO employees (first_name, last_name, department)
VALUES("ANTON", "Czysczesczkovicz", "IT")

INSERT INTO employees (first_name, last_name, department, hire_date)
VALUES("Maikle", "White", "Math", CURRENT_DATE)

INSERT INTO departments (dept_name, budget, manager_id)
VALUES ('IT', 120000, 1),
        ('HR', 80000, 2),
        ('Sales', 150000, 3)

INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ("Alisa", "Sigma", "Finance", 5000 * 1.1, CURRENT_DATE)

CREATE TEMP TABLE temp_employees AS
SELECT * FROM employees WHERE department = "IT"

-- part C

UPDATE employee
SET salary = salary * 1.1;

UPDATE temp_employees
SET status = "Senior"
WHERE salary > 60000 AND hire_date < '2023-01-01';

UPDATE temp_employees
SET department = CASE
    WHEN salary > 80000 THEN 'MANAGEMENT'
    WHEN salary BETWEEN 50000 and 80000 THEN "Senior"
    ELSE 'Junior'
END;

UPDATE employees
SET status = 'Senior'
WHERE salary > 60000 AND hire_date < '2023-01-01';

UPDATE employees
SET department = CASE
    WHEN salary > 80000 THEN "Management"
    WHEN slary BETWEEN 50000 and 80000 THEN 'Senior'
    ELSE 'Junior'
END;

UPDATE employees
SET department = DEFAULT
WHERE status = "Inactive"

UPDATE departments d
SET budget = (SELECT AVG(salary) = 1.2
            FROM employees e
            WHERE e.department = d.dept_name);

UPDATE employees
SET salary  = (SELECT AVG(salary) =1.2
                FROM employee e 
                WHERE e.department = d.dept_name);


PDATE employees
SET salary = salary * 1.15,
    status = 'Promoted'
WHERE department = 'Sales';

-- Part D

DELETE FROM employees
WHERE status = 'Terminated';

DELETE FROM employees
WHERE salary < 40000
  AND hire_date > '2023-01-01'
  AND department IS NULL;

DELETE FROM departments
WHERE dept_id NOT IN (
    SELECT DISTINCT department
    FROM employees
    WHERE department IS NOT NULL
);

DELETE FROM projects
WHERE end_date < '2023-01-01'
RETURNING *;

-- PArt E

INSERT INTO employees (first_name, last_name, salary, department)
VALUES ('Bob', 'Williams', NULL, NULL);

UPDATE employees
SET department = 'Unassigned'
WHERE department IS NULL;

DELETE FROM employees
WHERE salary IS NULL OR department IS NULL;

-- PARt F

INSERT INTO employees (first_name, last_name, department, hire_date)
VALUES ('Charlie', 'Brown', 'IT', CURRENT_DATE)
RETURNING emp_id, first_name || ' ' || last_name AS full_name;

UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT'
RETURNING emp_id, salary - 5000 AS old_salary, salary AS new_salary;

DELETE FROM employees
WHERE hire_date < '2020-01-01'
RETURNING *;

-- PArt G

INSERT INTO employees (first_name, last_name, department, hire_date)
SELECT 'Diana', 'Prince', 'HR', CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 FROM employees
    WHERE first_name = 'Diana' AND last_name = 'Prince'
);

UPDATE employees e
SET salary = salary * CASE
    WHEN (SELECT budget FROM departments d WHERE d.dept_name = e.department) > 100000
         THEN 1.10
    ELSE 1.05
END;

INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Eve', 'Adams', 'Sales', 50000, CURRENT_DATE),
       ('Frank', 'Miller', 'Sales', 52000, CURRENT_DATE),
       ('Grace', 'Hopper', 'Sales', 53000, CURRENT_DATE),
       ('Henry', 'Ford', 'Sales', 54000, CURRENT_DATE),
       ('Ivy', 'Taylor', 'Sales', 55000, CURRENT_DATE);

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Sales';

CREATE TABLE employee_archive AS
SELECT * FROM employees WHERE status = 'Inactive';

DELETE FROM employees
WHERE status = 'Inactive';

UPDATE projects p
SET end_date = end_date + INTERVAL '30 days'
WHERE budget > 50000
  AND (SELECT COUNT(*) FROM employees e WHERE e.department = p.dept_id) > 3;


