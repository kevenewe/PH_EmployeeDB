SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from retirement_info;

-- Create new table for retiring employees
DROP Table retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- updated queries usigng abreviations
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM  retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT COUNT (de.dept_no)
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
where de.dept_no = ('d006')

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
--INTO emp_count_bydept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

select * fROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
inner JOIN salaries as s
on (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
FROM current_emp as ce
INNER JOIN dept_emp AS d
ON (ce.emp_no = d.emp_no)
INNER JOIN departments AS d
ON (ce.dept_no = d.dept_no)


SELECT emp_no, first_name, last_name
INTO retirement_info_temp
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

Select ri.emp_no, ri.first_name, ri.last_name,
	d.dept_name
from retirement_info as ri
Inner JOIN dept_emp as de
on ri.emp_no = de.emp_no
INNER JOIN departments as d
on de.dept_no = d.dept_no
where d.dept_no in ('d007', 'd005')

-- Deliverable 1
-- 1. retrieve the emp_no, first_name, last_name columns from the employees table.
SELECT e.emp_no, e.first_name, e.last_name
from employees as e

-- 2. retrieve the title, from_date, and to_date columns from the titles table.
SELECT t.title, t.from_date, t.to_date
from titles as t
-- 3. create a new table using the into clause 

-- 4. join both tables on the primary key.
-- 5. Filter the data on the bird-date column to retrieve the employees who were born 
--		between 1952 and 1955. Then order by the employee number.
-- 6. Export the retirment titles table from the previous step as retirement_titles.csv 
-- 		and save it to your data folder in the Pewlett-Hackard-Analysis folder

SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
from employees as e
Left JOIN titles as t
on e.emp_no = t.emp_no
where (e.birth_date between '1952-01-01' AND '1955-12-31')
order by e.emp_no;

-- test to make sure table was created properly
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
from employees as e
Left JOIN titles as t
on e.emp_no = t.emp_no
where (e.birth_date between '1952-01-01' AND '1955-12-31')
order by e.emp_no;

-- Modify table structure so that emp_no is an integer
ALTER TABLE dept_manager ALTER COLUMN emp_no TYPE integer USING (emp_no::integer);

-- 9. Retrieve the employee number, first and last name, and title columns from the Retirement Titles Table
-- 10. Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each 
--		set of rows defined by the ON () clause.

SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name
	from retirement_titles as rt

-- 11. Exclude those employees that have already left the company by filtering on the to_date to keep 
--		only those dates that ae equal to 9999-01-01.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name
from retirement_titles as rt
where rt.to_date = ('9999-01-01')

-- 12. Create a Unique Titles table using the INTO clause
-- 13. Sort the unique titiles table in ascending order by the employee number and descending order by 
-- 		the last date (i.e., to_date) of the most recent title.
-- 14 exprt the Unique Titles table as unique_titles.csv and save it to your data folder in the 
--		Pewlett-hackard-analysis folder.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name,
	rt.title
--INTO unique_titles
from retirement_titles as rt
where rt.to_date = ('9999-01-01')
order by rt.emp_no ASC, rt.to_date DESC;


-- 16 Write query in the Employee_Database_challenge.sql file to 
--		rerieve he number of employees by their most recent job 
--		title who are about to retire.

-- 17. First retrieve the number of titles from the Unique Titles table
-- 18. Creat a Retiring Titles table to hold the required information
-- 19. Group the table by title, then sort the count column in descending order.
-- 20. export the Retiring titles table as retiring_titles.csv and save it to 
--		the data folder in the ewlett-Hackard-Analysis folder.

SELECT count(ut.title), rt.title
--INTO retiring_titles
FROM unique_titles as ut
LEFT JOIN retirement_titles as rt
ON ut.emp_no = rt.emp_no
where rt.to_date = '9999-01-01'
group by rt.title
order by COUNT (ut.title) desc;

-- add department to retiring_titles table.

DROP TABLE retiring_dept_titles;

SELECT count(ut.title), rt.title, de.dept_no
INTO retiring_dept_titles
FROM unique_titles as ut
INNER JOIN retirement_titles as rt
ON ut.emp_no = rt.emp_no
INNER JOIN dept_emp as de
on ut.emp_no = de.emp_no
where rt.to_date = '9999-01-01'
group by de.dept_no, rt.title
order by de.dept_no, COUNT (ut.title) desc;

-- Deliverable 2

-- 1. Retrieve the emp_no, first_name, last_name, birth_date columns from the employees table.
-- 2. Retrieve the from_date and to_date columns from theDepartment Employee table
-- 3. Retrieve the title column from the titles table
-- 4. Use a distinct on statement to retrieve the first occurrence of the employee number 
--		for each set of rows defined by the on ()
-- 5. Create a new table using the into clause.
-- 6. Join the Employees and the department employee tables on the primary key.
-- 7. Join the Employees and the Title tables on the primary key.
-- 8. Filter the data on the to_date column to all the current employees, then filter the data 
--		on the birth_date columns to get all the employees whose birth dates are between 
--		January 1, 1965 and December 31, 1965.
-- 9. Order the table by the employee number.
-- 10. Export the Mentorship Eligibility table as mentorship_eligibility.csv and save it to your 
--		Data folder in the Pewlett-Hackard-Analysis folder.



SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, 
	e.birth_date, de.from_date, de.to_date
--INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
on e.emp_no = de.emp_no
Inner join titles as t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND (e.birth_date between '1965-01-01' AND '1965-12-31')
order by e.emp_no;



SELECT count(ut.title), rt.title, d.dept_name
--INTO retiring_title_bydept
FROM unique_titles as ut
Inner JOIN retirement_titles as rt
ON ut.emp_no = rt.emp_no
INNER JOIN dept_emp as de
ON ut.emp_no = de.emp_no
INNER JOIN departments as d
on d.dept_no = de.dept_no
where rt.to_date = '9999-01-01'
group by d.dept_name, rt.title 
order by d.dept_name, COUNT (ut.title) desc;

