-- SQL Functions and Exercises with PostgreSQL Implementation

-- DATABASE STRUCTURE
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2),
    department_id INT REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE employee_projects (
    employee_id INT REFERENCES employees(employee_id),
    project_id INT REFERENCES projects(project_id),
    assigned_date DATE,
    PRIMARY KEY (employee_id, project_id)
);

-- INSERT DATA INTO TABLES
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Information Technology'),
(4, 'Marketing'),
(5, 'Legal'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'Sales'),
(9, 'Research and Development'),
(10, 'Procurement');

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, salary, department_id) VALUES
(101, 'Alice', 'Johnson', 'alice.johnson@company.com', '2015-03-15', 4500.00, 1),
(102, 'Bob', 'Smith', 'bob.smith@company.com', '2018-06-23', 5200.00, 3),
(103, 'Carol', 'Adams', 'carol.adams@company.com', '2012-09-10', 6700.00, 2),
(104, 'David', 'Lee', 'david.lee@company.com', '2020-01-05', 3800.00, 4),
(105, 'Eve', 'Martins', 'eve.martins@company.com', '2019-12-11', 4000.00, 3),
(106, 'Frank', 'Green', 'frank.green@company.com', '2017-07-08', 6000.00, 8),
(107, 'Grace', 'Brown', 'grace.brown@company.com', '2014-11-02', 4900.00, 5),
(108, 'Hank', 'Wilson', 'hank.wilson@company.com', '2013-02-17', 3100.00, 6),
(109, 'Ivy', 'Clark', 'ivy.clark@company.com', '2021-08-30', 2700.00, 9),
(110, 'Jake', 'White', 'jake.white@company.com', '2022-05-19', 3600.00, 7);

INSERT INTO projects (project_id, project_name, start_date, end_date) VALUES
(201, 'HR Revamp', '2023-01-01', '2023-12-31'),
(202, 'Finance Automation', '2022-05-15', '2023-04-30'),
(203, 'IT Infrastructure Upgrade', '2024-01-01', NULL),
(204, 'Marketing Blitz 2025', '2025-02-01', '2025-06-30'),
(205, 'Legal Compliance', '2023-07-10', '2024-01-10'),
(206, 'Customer Portal', '2021-11-01', '2022-10-31'),
(207, 'Sales Booster', '2022-04-01', '2023-03-31'),
(208, 'R&D Pilot', '2025-01-01', NULL),
(209, 'Procurement Tracker', '2024-03-15', '2024-11-15'),
(210, 'Operations Streamline', '2022-09-01', '2023-09-01');

INSERT INTO employee_projects (employee_id, project_id, assigned_date) VALUES
(101, 201, '2023-01-10'),
(102, 203, '2024-01-05'),
(103, 202, '2022-05-20'),
(104, 204, '2025-02-10'),
(105, 203, '2024-01-07'),
(106, 207, '2022-04-15'),
(107, 205, '2023-07-15'),
(108, 210, '2022-09-10'),
(109, 208, '2025-01-10'),
(110, 206, '2021-11-05');

    EXERCISES
1.Concatenate first and last name as full_name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

2.Convert all employee names to lowercase.
SELECT LOWER(first_name), LOWER(last_name) FROM employees;
-- 3
SELECT SUBSTRING(first_name, 1, 3) FROM employees;
-- 4
SELECT REPLACE(email, '@company.com', '@org.com') FROM employees;
-- 5
SELECT TRIM('   tax   ');
-- 6
SELECT first_name, last_name, LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length FROM employees;
-- 7
SELECT email, POSITION('@' IN email) FROM employees;
-- 8 (assuming gender column exists)
-- SELECT CASE WHEN gender='M' THEN 'Mr. '||first_name ELSE 'Ms. '||first_name END FROM employees;
-- 9
SELECT UPPER(project_name) FROM projects;
-- 10
SELECT REPLACE(project_name, '-', '') FROM projects;
-- 11
SELECT 'Emp: '||first_name||' '||last_name||' ('||d.department_name||')' FROM employees e JOIN departments d ON e.department_id=d.department_id;
-- 12
SELECT email, LENGTH(email) FROM employees;
-- 13
SELECT SPLIT_PART(email,'@',1) FROM employees;
-- 14
SELECT UPPER(last_name)||', '||INITCAP(first_name) FROM employees;
-- 15
SELECT first_name||' '||last_name||CASE WHEN ep.project_id IS NOT NULL THEN ' (Active)' ELSE '' END FROM employees e LEFT JOIN employee_projects ep ON e.employee_id=ep.employee_id AND ep.project_id IN (SELECT project_id FROM projects WHERE end_date IS NULL);
-- 16
SELECT first_name, ROUND(salary) FROM employees;
-- 17
SELECT * FROM employees WHERE MOD(CAST(salary AS INT),2)=0;
-- 18
SELECT project_name, end_date-start_date FROM projects WHERE end_date IS NOT NULL;
-- 19
SELECT ABS((SELECT salary FROM employees WHERE employee_id=101)-(SELECT salary FROM employees WHERE employee_id=102));
-- 20
SELECT first_name, salary, salary*POWER(1.10,1) FROM employees;
-- 21
SELECT ROUND(RANDOM()*10000);
-- 22
SELECT first_name, CEIL(salary), FLOOR(salary) FROM employees;
-- 23 (phone column assumed)
-- SELECT phone_number, LENGTH(phone_number) FROM employees;
-- 24
SELECT first_name, CASE WHEN salary>=5000 THEN 'High' WHEN salary>=3000 THEN 'Medium' ELSE 'Low' END FROM employees;
-- 25
SELECT first_name, LENGTH(CAST(salary AS TEXT)) FROM employees;
-- 26
SELECT CURRENT_DATE;
-- 27
SELECT first_name, CURRENT_DATE-hire_date FROM employees;
-- 28
SELECT * FROM employees WHERE EXTRACT(YEAR FROM hire_date)=EXTRACT(YEAR FROM CURRENT_DATE);
-- 29
SELECT NOW();
-- 30
SELECT first_name, EXTRACT(YEAR FROM hire_date), EXTRACT(MONTH FROM hire_date), EXTRACT(DAY FROM hire_date) FROM employees;
-- 31
SELECT * FROM employees WHERE hire_date<'2020-01-01';
-- 32
SELECT * FROM projects WHERE end_date >= CURRENT_DATE - INTERVAL '30 days';
-- 33
SELECT project_name, end_date-start_date FROM projects WHERE end_date IS NOT NULL;
-- 34
SELECT TO_CHAR(DATE '2025-07-23','Month DD, YYYY');
-- 35
SELECT project_name, CASE WHEN end_date IS NULL THEN 'Ongoing' ELSE 'Completed' END FROM projects;
-- 36
SELECT first_name, CASE WHEN salary>=5000 THEN 'High' WHEN salary>=3000 THEN 'Medium' ELSE 'Low' END FROM employees;
-- 37
SELECT first_name, COALESCE(email,'No Email') FROM employees;
-- 38
SELECT first_name, CASE WHEN hire_date<'2015-01-01' THEN 'Veteran' ELSE 'New' END FROM employees;
-- 39
SELECT first_name, COALESCE(salary,3000) FROM employees;
-- 40
SELECT first_name, CASE WHEN d.department_name='Information Technology' THEN 'IT' WHEN d.department_name='Human Resources' THEN 'HR' ELSE 'Other' END FROM employees e JOIN departments d ON e.department_id=d.department_id;
-- 41
SELECT e.first_name, CASE WHEN ep.project_id IS NULL THEN 'Unassigned' ELSE 'Assigned' END FROM employees e LEFT JOIN employee_projects ep ON e.employee_id=ep.employee_id;
-- 42
SELECT first_name, CASE WHEN salary>=6000 THEN 'Top Band' WHEN salary>=4000 THEN 'Mid Band' ELSE 'Low Band' END FROM employees;
-- 43
SELECT project_name, CASE WHEN (end_date-start_date)>365 THEN 'Long' WHEN (end_date-start_date)>180 THEN 'Medium' ELSE 'Short' END FROM projects WHERE end_date IS NOT NULL;
-- 44
SELECT employee_id, CASE WHEN MOD(employee_id,2)=0 THEN 'Even' ELSE 'Odd' END FROM employees;
-- 45
SELECT COALESCE(first_name||' '||last_name,'No Name') FROM employees;
-- 46
SELECT first_name, CASE WHEN LENGTH(first_name||last_name)>10 THEN 'Long Name' ELSE 'Short Name' END FROM employees;
-- 47
SELECT email, CASE WHEN UPPER(email) LIKE '%TEST%' THEN 'Dummy' ELSE 'Valid' END FROM employees;
-- 48
SELECT first_name, CASE WHEN EXTRACT(YEAR FROM hire_date)<=2015 THEN 'Senior' ELSE 'Junior' END FROM employees;
-- 49
SELECT first_name, CASE WHEN salary<3000 THEN 'Increase by 20%' WHEN salary<5000 THEN 'Increase by 10%' ELSE 'Increase by 5%' END FROM employees;
-- 50
SELECT first_name, CASE WHEN EXTRACT(MONTH FROM hire_date)=EXTRACT(MONTH FROM CURRENT_DATE) THEN 'Anniversary Month' ELSE 'Regular Month' END FROM employees;
