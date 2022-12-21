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
INTO emp_count_bydept
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


-- 1. retrieve the emp_no, first_name, last_name columns from the employees table.
-- 2. retrieve the title, from_date, and to_date columns from the titles table.
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
-- 11. Exclude those employees that have already left eh company by filtering on the to_date to keep 
--		only those dates that ae equal to 9999-01-01.
-- 12. Create a Unique Titles table using the INTO clause
-- 13. Sort the unique titiles table in ascending order by the employee number and descending order by 
-- 		the last date (i.e., to_date) of the most recent title.
-- 14 exprt the Unique Titles table as unique_titles.csv and save it to your data folder in the 
--		Pewlett-hackard-analysis folder.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name,
	rt.title
INTO unique_titles
from retirement_titles as rt
where rt.to_date = ('9999-01-01')
order by rt.emp_no ASC, rt.to_date DESC;


-- 16


