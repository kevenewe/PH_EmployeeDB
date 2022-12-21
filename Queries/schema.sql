--drop table titles;
	
	Create Table titles(
		emp_no int Not NULL,
		title varchar,
		from_date DATE NOT NULL,
  		to_date DATE NOT NULL,
		primary key (emp_no, title, to_date)
	);
	
	Select * from titles;
	
drop table departments;

	Create TABLE departments (
		dept_no varchar,
		dept_name varchar,
		primary key(dept_no),
		Unique (dept_name)
		);
		
	select * from departments
	
	Create TABLE employees (
		emp_no int,
		birth_date date,
		first_name varchar,
		last_name varchar,
		gender varchar,
		hire_date date,
		primary key(emp_no)
		);

drop table Managers;

	Create TABLE dept_managers (
		dept_no varchar,
		emp_no int,
		from_date date,
		to_date date,
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
		primary key(dept_no)
		);
		
	Create TABLE dept_emp (
		dept_no varchar,
		emp_no int,
		from_date date,
		to_date date,
		primary key (dept_no)
		);
DROP TABLE salaties;

	CREATE TABLE salaries (
		emp_no int,
		salary int,
		from_date date,
		to_date date,
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no)
	);
	
		
		
	
		