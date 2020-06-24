-- Problem statements from https://data36.com/sql-interview-questions-tech-screening-data-analysts/
-- NOTE: The page presents its own solutions. Here I present mine.

-- -----------------------
--       Question #1
-- -----------------------
/*
Let’s say you have two SQL tables: 
	authors and books.
The authors dataset has 1M+ rows; here’s the first six rows:
	___________________________
	author_name		book_name
	author_1		book_1
	author_1		book_2
	author_2		book_3
	author_2		book_4
	author_2		book_5
	author_3		book_6
	…				…
	___________________________

The books dataset also has 1M+ rows and here’s the first six:

	___________________________
	book_name	sold_copies
	book_1		1000
	book_2		1500
	book_3		34000
	book_4		29000
	book_5		40000
	book_6		4400
	…			…
	___________________________

>>>> Create an SQL query that shows the TOP 3 authors who sold the most books in total!
*/

-- SQL
SELECT TOP 3 a.author_name, SUM(b.sold_copies) AS Total_sold_books_per_author
FROM authors AS A INNER JOIN books AS B ON A.book_name=B.book_name
GROUP BY author_name
ORDER BY SUM(b.sold_copies) DESC;

-- In MySQL
SELECT a.author_name, SUM(b.sold_copies) AS Total_sold_books_per_author
FROM authors AS A INNER JOIN books AS B ON A.book_name=B.book_name
GROUP BY author_name
ORDER BY SUM(b.sold_copies) DESC LIMIT 0,3;


-- -----------------------
--       Question #2
-- -----------------------
/*
You work for a startup that makes an online presentation software. You have an event log that 
records every time a user inserted an image into a presentation. 
(One user can insert multiple images.) The event_log SQL table looks like this:
	___________________________
	user_id		event_date_time
	7494212		1535308430
	7494212		1535308433
	1475185		1535308444
	6946725		1535308475
	6946725		1535308476
	6946725		1535308477
	…			…
	___________________________

…and it has over one billion rows.
Note: If the event_date_time column’s format doesn’t look familiar, google “epoch timestamp”!

>>>> Write an SQL query to find out how many users inserted more than 1000 but less than 2000 images in their presentations!
*/
-- Mi propuesta de solución.
-- Mi solución esta ok pero muestra dos columnas, el ID de usuario y la cantidad, y el enunciado solo pide cantidades
SELECT COUNT(user_amount) AS Total_users
FROM(
SELECT user_id, COUNT(user_id) AS user_amount
FROM event_log 
GROUP BY user_id
HAVING COUNT(event_date_time) > 1 AND COUNT(event_date_time) < 4
) AS subquery;


-- In case you can run the query for this problem, here are the query for creating a database and the tables.
CREATE DATABASE startupdb;
USE startupdb;
CREATE TABLE event_log(
	id int auto_increment,
    user_id int,
    event_date_time int,
    primary key(id)
);

INSERT INTO event_log
	(user_id, event_date_time)
VALUES
	(7494212,1535308430),
	(7494212,1535308433),
	(1475185,1535308463),
	(6946725,1535308232),
	(6946725,1535308733),
	(6946725,1535308733),
	(1116725,1535305753),
	(1116725,1535308442),
	(1116725,1535308534),
	(1116725,1535308432)
;


-- -----------------------
--       Question #3
-- -----------------------
/*
You have two SQL tables! The first one is called
	'employees' and it contains the 
		employee names, 
		the unique employee ids and 
		the department names of a company. 
Sample:

	________________________________________________________
	department_name		employee_id		employee_name
	Sales				123				John Doe
	Sales				211				Jane Smith
	HR					556				Billy Bob
	Sales				711				Robert Hayek
	Marketing			235				Edward Jorgson
	Marketing			236				Christine Packard
	…					…				…
	________________________________________________________

The second one is named 'salaries'. It holds the same employee names and the same employee ids – and the salaries for each employee. Sample:

	________________________________________________________
	salary		employee_id		employee_name
	500			123				John Doe
	600			211				Jane Smith
	1000		556				Billy Bob
	400			711				Robert Hayek
	1200		235				Edward Jorgson
	200			236				Christine Packard
	…			…				…
	________________________________________________________

The company has 546 employees, so both tables have 546 rows.

>>>> Print every department where the average salary per employee is lower than $500!
*/
-- Here are presented two alternative queries for this exercise.
SELECT department_name, avg_salary_by_depto
FROM
	(SELECT AVG(S.salary) AS avg_salary_by_depto, S.employee_id, E.department_name
	FROM salaries AS S INNER JOIN employees AS E ON S.employee_id=E.employee_id
	GROUP BY department_name)
	AS subq_avg_salary_by_depto
WHERE avg_salary_by_depto < 500;

-- This one is using HAVING clause.
SELECT AVG(S.salary) AS Avg_salary_per_dep, E.department_name
FROM salaries AS S INNER JOIN employees AS E ON S.employee_id=E.employee_id
GROUP BY E.department_name
HAVING AVG(S.salary) < 500;

-- In case you can run the query for this problem, here are the query for creating a database and the tables.
CREATE DATABASE employeesdb;
USE employeesdb;
CREATE TABLE employees(
	id int auto_increment,
	department_name varchar(200),		
	employee_id	int,
	employee_name varchar(150),
	primary key(id)
);

INSERT INTO employees (department_name, employee_id, employee_name)
VALUES
	('Sales', 123, 'John Doe'),
	('Sales', 211, 'Jane Smith'),
	('HR', 556, 'Billy Bob'),
	('Sales', 711, 'Robert Hayek'),
	('Marketing', 235, 'Edward Jorgson'),
	('Marketing', 236, 'Christine Packard')
;

CREATE TABLE salaries(
	id int auto_increment,
	salary int,
	employee_id int,		
	employee_name varchar(150),
	primary key (id)
);

INSERT INTO salaries (salary, employee_id, employee_name)
VALUES
	(500, 123, 'John Doe'),
	(600, 211, 'Jane Smith'),
	(1000, 556, 'Billy Bob'),
	(400, 711, 'Robert Hayek'),
	(1200, 235, 'Edward Jorgson'),
	(200, 236, 'Christine Packard')
;