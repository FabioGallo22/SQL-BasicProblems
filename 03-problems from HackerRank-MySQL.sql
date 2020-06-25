-- Problems from https://www.hackerrank.com/domains/sql

/* (Description from https://www.hackerrank.com/challenges/weather-observation-station-8/problem)
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

Input Format

The STATION table is described as follows:
	Field	Type
	ID		NUMBER
	CITY	VARCHAR(21)
	STATE	VARCHAR(2)
	LAT_N	NUMBER
	LONG_W	NUMBER
*/
	select distinct city from station 
	where substring(city, 1, 1) IN('a','e','i','o','u')
		  AND
		  substring(city, length(city), 1) IN('a','e','i','o','u');

/*(Description from https://www.hackerrank.com/challenges/weather-observation-station-9/problem)
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

Input Format

The STATION table is described as follows:
	Field	Type
	ID		NUMBER
	CITY	VARCHAR(21)
	STATE	VARCHAR(2)
	LAT_N	NUMBER
	LONG_W	NUMBER
*/
SELECT DISTINCT city FROM station WHERE substring(city,1,1) NOT IN('a','e','i','o','u');

/* (Description from https://www.hackerrank.com/challenges/weather-observation-station-10/problem9)
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

Input Format

The STATION table is described as follows:
	Field	Type
	ID		NUMBER
	CITY	VARCHAR(21)
	STATE	VARCHAR(2)
	LAT_N	NUMBER
	LONG_W	NUMBER
*/
SELECT DISTINCT city FROM station WHERE substring(city, length(city),1) NOT IN('a','e','i','o','u');

/* (Description from https://www.hackerrank.com/challenges/weather-observation-station-11/problem)
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

Input Format

The STATION table is described as follows:
	Field	Type
	ID		NUMBER
	CITY	VARCHAR(21)
	STATE	VARCHAR(2)
	LAT_N	NUMBER
	LONG_W	NUMBER
*/
SELECT DISTINCT city 
FROM station 
WHERE substring(city,1,1) NOT IN('a','e','i','o','u')
      OR
      substring(city,length(city),1) NOT IN('a','e','i','o','u');
	  
/* (Description from https://www.hackerrank.com/challenges/weather-observation-station-12/problem)
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

Input Format

The STATION table is described as follows:
	Field	Type
	ID		NUMBER
	CITY	VARCHAR(21)
	STATE	VARCHAR(2)
	LAT_N	NUMBER
	LONG_W	NUMBER
*/
SELECT DISTINCT city 
FROM station 
WHERE substring(city,1,1) NOT IN('a','e','i','o','u')
      AND
      substring(city,length(city),1) NOT IN('a','e','i','o','u');
	  
/* (Description from https://www.hackerrank.com/challenges/more-than-75-marks/problem)
Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

Input Format
	Column	Type
	ID		Integer
	Name	String	
	Marks	Integer
	
The Name column only contains uppercase (A-Z) and lowercase (a-z) letters.
The STUDENTS table is described as follows:  

Sample Input
	______________________
	ID	Name		Marks
	1	Ashley		81
	2	Samantha	75
	4	Julia		76
	3	Belvet		84
	______________________
	
Sample Output:
	Ashley
	Julia
	Belvet
	
Explanation:
Only Ashley, Julia, and Belvet have Marks > 75. If you look at the last three characters of each of their names, there are no duplicates and 'ley' < 'lia' < 'vet'.
*/
SELECT NAME
FROM STUDENTS
WHERE marks > 75
ORDER BY substring(name, length(name) - 2, 3) ASC, id ASC;  -- Instead of substring(name, length(name) - 2, 3) could be right(name,3), and it would be ok too.

/* (Description from https://www.hackerrank.com/challenges/what-type-of-triangle/problem)
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
Input Format

The TRIANGLES table is described as follows:

	________________
	Column	Type
	A		Integer
	B		Integer
	C		Integer
	________________
	
Each row in the table denotes the lengths of each of a triangle's three sides.

Sample Input
	___________
	A	B	C
	20	20	23
	20	20	20
	20	21	22
	13	14	30
	___________

Sample Output
	Isosceles
	Equilateral
	Scalene
	Not A Triangle
	
Explanation
Values in the tuple (20,20,23) form an Isosceles triangle, because A≡B.
Values in the tuple (20,20,20) form an Equilateral triangle, because A≡B≡C. 
Values in the tuple (20,21,22) form a Scalene triangle, because A<>B<>C.
Values in the tuple (13,14,30) cannot form a triangle because the combined value of sides A and B is not larger than that of side C.	
	
*/
	-- This problems is not fully described, thus my solution does not pass 100% of the test cases.
		SELECT 
			case
				WHEN A=B AND B=C then 'Equilateral'
				WHEN A<>B AND B<>C AND C<>A then 'Scalene' 
				WHEN A=B OR B=C OR C=A then 'Isosceles'
				else 'Not A Triangle'
			end
		FROM triangles;

/* (Description from https://www.hackerrank.com/challenges/the-pads/problem)
Generate the following two result sets:

1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

2. There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.

Input Format
	___________________
	Column		Type
	Name		String
	Occupation	String
	___________________
	
Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
The OCCUPATIONS table is described as follows:  

Sample Input

An OCCUPATIONS table that contains the following records:	
	________________________
	Name		Occupation
	Samantha	Doctor
	Julia		Actor
	Maria		Actor
	Meera		Singer
	Ashely		Professor
	Ketty		Professor
	Christeen	Professor
	Jone		Actor
	Jenny		Doctor
	Priya		Singer
	________________________
	
Sample Output
	Ashely(P)
	Christeen(P)
	Jane(A)
	Jenny(D)
	Julia(A)
	Ketty(P)
	Maria(A)
	Meera(S)
	Priya(S)
	Samantha(D)
	There are a total of 2 doctors.
	There are a total of 2 singers.
	There are a total of 3 actors.
	There are a total of 3 professors.

Explanation:
The results of the first query are formatted to the problem description's specifications.
The results of the second query are ascendingly ordered first by number of names corresponding to each profession (2<=2<=3<=3), and then alphabetically by profession (doctor<=singer, and actor<=professor).
*/
	SELECT CONCAT(name, '(', substring(occupation,1,1) , ')')
		FROM occupations
		ORDER BY name;
	SELECT CONCAT('There are a total of ', COUNT(name), ' ', lcase(occupation), 's.')
		FROM occupations
		GROUP BY occupation
		ORDER BY COUNT(name) ASC
	;

/* (Description https://www.hackerrank.com/challenges/binary-search-tree-1/problem)
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
	________________
	Column	Type
	N		Integer
	P		Integer
	________________

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
	- Root: If node is root node.
	- Leaf: If node is leaf node.
	- Inner: If node is neither root nor leaf node.
	
Sample Input
	_________
	N	P
	1	2
	3	2
	6	8
	9	8
	2	5
	8	5
	5	null
	_________

Sample Output
	1 Leaf
	2 Inner
	3 Leaf
	5 Root
	6 Leaf
	8 Inner
	9 Leaf
*/
SELECT 
    case 
        when (SELECT count(*) FROM bst WHERE n=one_node AND p is null) > 0
            THEN CONCAT(one_node, ' Root')
        when (SELECT count(*) FROM bst WHERE n=one_node) > 0 
             AND 
             (SELECT count(*) FROM bst WHERE p=one_node) > 0
			THEN CONCAT(one_node, ' Inner')
        ELSE CONCAT(one_node, ' Leaf')
    end
FROM
    (SELECT DISTINCT(nodes) AS one_node
    FROM
        ((SELECT N AS nodes from bst)
        union
        (SELECT P from bst)) AS all_nodes
    WHERE nodes IS NOT null
    ORDER BY nodes ASC) AS all_nodes_dist
;

/* (Description	from https://www.hackerrank.com/challenges/earnings-of-employees/problem)
We define an employee's total earnings to be their monthly salary * months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.

Input Format

The Employee table containing employee data for a company is described as follows:
	_________________________
	Column			Type
	employee_id		Integer
	name			String
	months			Integer
	salary			Integer
	_________________________

where employee_id is an employee's ID number, name is their name, months is the total number of months they've been working for the company, and salary is the their monthly salary.

Sample Input
	__________________________________________
	employee_id		name		months	salary
	12228			Rose		15		1968
	33645			Angela		1		3443
	45692			Frank		17		1608
	56118			Patrick		7		1345
	59725			Lisa		11		2330
	74197			Kimberly	16		4372
	78454			Bonnie		8		1771
	83565			Michael		6		2017
	98607			Tood		5		3396
	99989			Joe			9		3573
	__________________________________________
	
Sample Output:
	69952 1

Explanation:
The table and earnings data is depicted in the following diagram:
	____________________________________________________________
	employee_id		name		months	salary		earnings
	12228			Rose		15		1968		29520
	33645			Angela		1		3443		3443
	45692			Frank		17		1608		27336
	56118			Patrick		7		1345		9415
	59725			Lisa		11		2330		25630
	74197			Kimberly	16		4372		69952
	78454			Bonnie		8		1771		14168
	83565			Michael		6		2017		12102
	98607			Tood		5		3396		16980
	99989			Joe			9		3573		32157
	____________________________________________________________
	
The maximum earnings value is 69952. The only employee with earnings = 69952 is Kimberly, so we print the maximum earnings value (69952) and a count of the number of employees who have earned $69952 (which is 1) as two space-separated values.
	
*/
	SELECT (salary * months) as earnings ,count(*) 
	FROM employee 
	GROUP BY 1 
	ORDER BY earnings DESC limit 1;

/*	(Description from https://www.hackerrank.com/challenges/the-report/problem)
You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
	_________________
	Column	Type
	ID		Integer
	Name	String
	Marks	Integer
	_________________
	
Grades contains the following data:
	______________________________
	Grades	Min_Mark	Max_Mark
	1		0			9
	2		10			19	
	3		20			29
	4		30			39	
	5		40			49
	6		50			59	
	7		60			69	
	8		70			79
	9		80			89
	10		90			100
	______________________________

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.

Sample Input
	______________________
	ID	Name		Marks
	1	Julia		88
	2	Samantha	68
	3	Maria		99
	4	Scarlet		78
	5	Ashley		63	
	6	Jane		81
	______________________

Sample Output
	Maria 10 99
	Jane 9 81
	Julia 9 88 
	Scarlet 8 78
	NULL 7 63
	NULL 7 68

Note:
Print "NULL"  as the name if the grade is less than 8.

Explanation:
Consider the following table with the grades assigned to the students:	
	_________________________________
	ID	Name		Marks	Grade
	1	Julia		88		9
	2	Samantha	68		7
	3	Maria		99		10
	4	Scarlet		78		8
	5	Ashley		63		7
	6	Jane		81		9
	_________________________________

So, the following students got 8, 9 or 10 grades:
	- Maria (grade 10)
	- Jane (grade 9)
	- Julia (grade 9)
	- Scarlet (grade 8)
*/
		SELECT 
		case 
			when g.grade >= 8 THEN s.name
			else null
		end,
		g.grade,
		s.marks
		FROM students AS s 
		INNER JOIN grades AS g
		ON s.marks>=g.min_mark AND s.marks<=g.max_mark
		ORDER BY g.grade DESC;
	





