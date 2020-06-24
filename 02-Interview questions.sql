-- Problem statements from https://www.techbeamers.com/sql-query-questions-answers-for-practice/
-- NOTE: The page presents its own solutions. Here I present my solutions to the most complex queries.

/*
Given these three tables:

	Sample Table – Worker
		_______________________________________________________________________________
		WORKER_ID	FIRST_NAME	LAST_NAME	SALARY	JOINING_DATE			DEPARTMENT
		001			Monika		Arora		100000	2014-02-20 09:00:00		HR
		002			Niharika	Verma		80000	2014-06-11 09:00:00		Admin
		003			Vishal		Singhal		300000	2014-02-20 09:00:00		HR
		004			Amitabh		Singh		500000	2014-02-20 09:00:00		Admin
		005			Vivek		Bhati		500000	2014-06-11 09:00:00		Admin
		006			Vipul		Diwan		200000	2014-06-11 09:00:00		Account
		007			Satish		Kumar		75000	2014-01-20 09:00:00		Account
		008			Geetika		Chauhan		90000	2014-04-11 09:00:00		Admin
		...			...			...			...		...						...
		_______________________________________________________________________________
	
	Sample Table – Bonus
		______________________________________________________
		WORKER_REF_ID	BONUS_DATE				BONUS_AMOUNT
		1				2016-02-20 00:00:00		5000
		2				2016-06-11 00:00:00		3000
		3				2016-02-20 00:00:00		4000
		1				2016-02-20 00:00:00		4500
		2				2016-06-11 00:00:00		3500
		...				...						...
		______________________________________________________
	
	Sample Table – Title
		______________________________________________________	
		WORKER_REF_ID	WORKER_TITLE	AFFECTED_FROM
		1				Manager			2016-02-20 00:00:00
		2				Executive		2016-06-11 00:00:00
		8				Executive		2016-06-11 00:00:00
		5				Manager			2016-06-11 00:00:00
		4				Asst. Manager	2016-06-11 00:00:00
		7				Executive		2016-06-11 00:00:00
		6				Lead			2016-06-11 00:00:00
		3				Lead			2016-06-11 00:00:00
		...				...				...
		______________________________________________________
		
	NOTE: At the end of this document are the scripts to create this tables. This was provided by the problem statements' web page.
*/

-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
	SELECT CONCAT(first_name, ', ', last_name) AS full_name FROM worker WHERE salary BETWEEN 50000 AND 100000;
	
-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
	SELECT COUNT(worker_id) AS cant_wotkers, department
	FROM worker
	GROUP BY department
	ORDER BY cant_wotkers DESC;
	
-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
	SELECT W.*
	FROM worker AS W INNER JOIN title AS T ON W.worker_id=T.worker_ref_id
	WHERE T.worker_title='Manager';

-- Q-26. Write an SQL query to show only odd rows from a table.
	SELECT *
	FROM worker WHERE worker_id%2=1;
	
-- Q-27. Write an SQL query to show only even rows from a table.
	SELECT * FROM worker WHERE worker_id%2=0;

-- Q-28. Write an SQL query to clone a new table from another table.
	SELECT * INTO worker_clone FROM worker;

Q-29. Write an SQL query to fetch intersecting records of two tables.
	-- SQL
		(SELECT * FROM Worker)
		INTERSECT
		(SELECT * FROM WorkerClone);
	
	-- MySQL
		SELECT DISTINCT *
		FROM worker INNER JOIN workerclone USING(worker_id);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
	SELECT * FROM Worker
	MINUS
	SELECT * FROM Title;
	
-- Q-31. Write an SQL query to show the current date and time. 
	-- MySQL
		SELECT CURDATE();
		
-- Q-32. Write an SQL query to show the top n (say 10) records of a table.
	-- SQL
		SELECT TOP 10 *
		FROM worker;
		
	-- MySQL
		SELECT * FROM worker limit 10;
		
-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
	-- MySQL
	SELECT Salary FROM Worker ORDER BY Salary DESC LIMIT 5,1;

-- Q-35. Write an SQL query to fetch the list of employees with the same salary. (otro self join)
	SELECT DISTINCT A.worker_id, CONCAT(A.last_name, ', ', A.first_name) AS full_name, A.salary
	FROM worker AS A INNER JOIN worker AS B
	WHERE A.worker_id<>B.worker_id AND A.salary=B.salary
    ORDER BY A.salary; 

-- Q-37. Write an SQL query to show one row twice in results from a table.
	select FIRST_NAME, DEPARTMENT from worker W where W.DEPARTMENT='HR' 
	union all 
	select FIRST_NAME, DEPARTMENT from Worker W1 where W1.DEPARTMENT='HR';
	
-- Q-38. Write an SQL query to fetch intersecting records of two tables.
	(SELECT * FROM Worker)
	INTERSECT
	(SELECT * FROM WorkerClone);
	
-- Q-40. Write an SQL query to fetch the departments that have less than five people in it.
	SELECT COUNT(worker_id) AS total_workers, department
	FROM worker
	GROUP BY department
	HAVING total_workers < 5;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
	SELECT COUNT(worker_id) AS total_people, department
	FROM worker 
	GROUP BY department
	ORDER BY total_people DESC;
	
-- Q-42. Write an SQL query to show the last record from a table.
	SELECT * FROM worker 
	WHERE worker_id = (SELECT MAX(worker_id) FROM worker);

-- Q-43. Write an SQL query to fetch the first row of a table.
	SELECT * from title 
	WHERE worker_ref_id = (SELECT min(worker_ref_id) FROM title);
	
-- Q-44. Write an SQL query to fetch the last five records from a table.
-- MySQL
	SELECT *
	FROM worker 
	ORDER BY worker_id DESC 
	limit 0,5;
	
--Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
	SELECT W.worker_id, W.salary, W.department
	FROM 
		(SELECT MAX(salary) AS max_salary, department
		 FROM worker
		 GROUP BY department
		) AS max_salary_per_dept
		INNER JOIN worker AS W 
		ON max_salary_per_dept.max_salary=W.salary 
			AND 
		   max_salary_per_dept.department=W.department
	;
	
-- Q-46. Write an SQL query to fetch three max salaries from a table.
	-- MySQL
		SELECT * FROM
			(SELECT DISTINCT SALARY
			FROM worker
			ORDER BY SALARY DESC
			) AS subq
		LIMIT 0,3;

		
-- Q-47. Write an SQL query to fetch three min salaries from a table. PARECIDO AL EJERCICIO ANTERIOR
	-- MySQL
	SELECT * 
	FROM
		(SELECT DISTINCT salary FROM worker ORDER BY salary ASC) AS all_salaries_asc
	limit 0,3;
	
-- Q-48. Write an SQL query to fetch nth max salaries from a table.
	SELECT distinct Salary from worker a 
	WHERE n >= (
		SELECT count(distinct Salary) 
		from worker b 
		WHERE a.Salary <= b.Salary) 
	order by a.Salary desc;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
	SELECT SUM(salary) AS Total_paid_salary, department
	FROM worker
	GROUP BY department
	ORDER BY department;
	
-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
	SELECT CONCAT(last_name, ', ', first_name) AS full_name, salary
	FROM worker
	WHERE salary IN (SELECT MAX(salary) FROM worker); 





-- SQL Script to Seed Sample Data (from https://www.techbeamers.com/sql-query-questions-answers-for-practice/)
CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');