-- People born between 1952 and 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- People born in 1952 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


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

--Create new table for retiring employees
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables to create new table containint current emps
--eligible for for retirement
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

DROP TABLE emp_count_department;

-- Employee count by department number group by dept_no
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_department
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--Check the table
SELECT * FROM emp_count_department;

--Sort date column in descending order
SELECT * FROM salaries
ORDER BY to_date DESC;

--Join Salaries and Employees tables
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

--Check table	 
SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

--Check table
SELECT * FROM manager_info;

--inner joins on the current_emp, departments, and dept_emp to include the list of 
--columns we’ll need to present
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no);
--Check Table
SELECT * FROM dept_info;
--an additional list, containing only employees in the Sales and Development departments
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO sales_info
FROM retirement_info as ri
Inner Join dept_emp as de
ON (ri.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no)
WHERE (d.dept_name='Sales');

SELECT * FROM sales_info;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO sales_devel_info
FROM retirement_info as ri
Inner Join dept_emp as de
ON (ri.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');

SELECT * FROM sales_devel_info;




COPY departments FROM '/Users/abigailwoolf/Public/departments.csv' DELIMITER ',' CSV HEADER;
COPY employees FROM '/Users/abigailwoolf/Public/employees.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM '/Users/abigailwoolf/Public/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM '/Users/abigailwoolf/Public/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM '/Users/abigailwoolf/Public/salaries.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM '/Users/abigailwoolf/Public/titles.csv' DELIMITER ',' CSV HEADER;


