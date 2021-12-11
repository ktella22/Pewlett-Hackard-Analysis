-- Use Dictinct with Orderby to remove duplicate rows

-- Delivery 1
-- creating retirement_titles
select  e.emp_no, e.first_name, e.last_name, 
		t.title, t.from_date, t.to_date
into retirement_titles
from employees as e
join titles as t
on e.emp_no = t.emp_no
where (birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;
 
-- Create Unique Titles table
SELECT DISTINCT ON (emp_no) emp_no,
			first_name, last_name, 
			title
INTO unique_titles
FROM retirement_titles 
ORDER BY emp_no, to_date desc;

-- Create retiring titles table
select count(emp_no) as "count", title
into retiring_titles
from unique_titles
group by title
order by "count" desc; 

-- Delivery 2 
-- Memtorhsip Eligibility table
select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, 
	e.birth_date, de.from_date, de.to_date, t.title
into mentorship_eligibility
from employees as e
inner join dept_emp as de 
on (e.emp_no = de.emp_no)
inner join titles as t
on (e.emp_no = t.emp_no)
where (de.to_date = '9999-01-01') and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no; 



