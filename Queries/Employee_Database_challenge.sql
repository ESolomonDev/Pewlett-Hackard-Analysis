--create the retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
	INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--check the retirement_titles table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO most_recent_title
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no , last_name DESC;

--check the most_recent_title table
SELECT * FROM most_recent_title;

--retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(mrt.emp_no), mrt.title
INTO retiring_titles
FROM most_recent_title AS mrt
GROUP BY mrt.title
ORDER BY count DESC;

--check table retiring_titles
SELECT * FROM retiring_titles;

--a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	dm.from_date,
	dm.to_date,
	ti.title
	INTO mentorship_eligibility
	FROM employees as e
		INNER JOIN dept_emp as dm
			ON (e.emp_no = dm.emp_no)
		INNER JOIN titles as ti
			ON (e.emp_no = ti.emp_no)
	WHERE (dm.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY e.emp_no;


--count by department for mentorship
SELECT COUNT(emp_no),
title
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT DESC;