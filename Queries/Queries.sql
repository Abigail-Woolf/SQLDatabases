COPY departments FROM '/Users/abigailwoolf/Public/departments.csv' DELIMITER ',' CSV HEADER;
COPY employees FROM '/Users/abigailwoolf/Public/employees.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM '/Users/abigailwoolf/Public/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM '/Users/abigailwoolf/Public/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM '/Users/abigailwoolf/Public/salaries.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM '/Users/abigailwoolf/Public/titles.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date Between '1952-01-01' AND '1952-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--Retirement eleigibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

SELECT * FROM retirement_info;