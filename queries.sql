-- Employee born between 1952 and 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

-- Making retirement_info folder
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees 
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table 
SELECT * FROM retirement_info; 

-- Joining retirement
SELECT retirement_info.emp_no, 
	retirement_info.first_name, 
	retirement_info.last_name, 
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no; 

-- Joining departments and dept_manager tables with alias
SELECT d.dept_name, 
	dm.emp_no, 
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no; 


-- Joining retirement and department employee as alias 
SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no; 

SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01'); 
-- SELECT current_emp table
SELECT * FROM current_emp; 

-- Employee count by department number 
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no; 

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

-- List of managers per department
SELECT dm.dept_no, 
	d.dept_name,
	dm.emp_no, 
	ce.last_name, 
	ce.first_name, 
	dm.from_date, 
	dm.to_date
INTO manager_info
FROM dept_manager as dm
	INNER JOIN departments as d
	ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
	ON dm.emp_no = ce.emp_no; 


SELECT ce.emp_no, 
	ce.first_name, 
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

-- Tailered list for Sale department  
SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name,
 	di.dept_name
FROM retirement_info as ri
INNER JOIN dept_info as di
ON ri.emp_no = di.emp_no
WHERE di.dept_name = 'Sales';

-- Tailered list for Sale and Development team  
SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name,
 	di.dept_name
FROM retirement_info as ri
INNER JOIN dept_info as di
ON ri.emp_no = di.emp_no
WHERE di.dept_name IN ('Sales', 'Development');