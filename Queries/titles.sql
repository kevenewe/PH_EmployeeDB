	drop table titles;
	
	Create Table titles(
		emp_no varchar Not NULL,
		title varchar,
		from_date DATE NOT NULL,
  		to_date DATE NOT NULL,
		primary key (emp_no, title, to_date)
	);
	
	Select * from titles;
	