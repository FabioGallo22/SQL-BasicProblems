/*
	In this task we will consider some ducks. Each duck belongs to a particular species and lives in one of several ponds. Each pond is described by its temperature and location city. Each species is described by two values: its thermal preferences and its limit. Depending on their thermal preferences, ducks from a given species may prefer tempetures not higher or not lower than the temperature limit. A duck of a certain species will only feel comfortable if the temperature in the pond fulfills its thermal preference (i.e. it is above/below or equal to the species' limit temperature).
	You are given three tables: species, ponds and ducks, with following structure:
	
	create table species(
		id integer not null,
		temp_preferences varchar(1) check(temp_preferences in ('+','-')),
		temp_limit integer not null,
		unique(id)
	);
	
	create table ponds(
		id integer not null,
		temperature integer not null,
		city varchar(10),
		unique(id)
	);
	
	create table ducks(
		id integer not null,
		name varchar(10),
		species_id integer not null,
		pond_id integer not null,
		unique(id)
	);
	
The column temp_preferences in table species determines whether temp_limit is the minimum ("+") or maximum ("-") acceptable temperature for the given species.
For each pond we would like to count the ducks which live in it and feel comfortable.
Write an SQL query that returns a table consisting of two columns: pond_id, happy_ducks, ordered by pond_id. Every pond should appear in this table.	
*/

SELECT p.id,
    COUNT(
    CASE
        WHEN S.temp_preferences = '+' AND P.temperature >  S.temp_limit THEN d.id
        WHEN S.temp_preferences = '-' AND P.temperature <  S.temp_limit THEN d.id
        ELSE null
    END
    ) AS happy_ducks
FROM ducks AS D RIGHT JOIN ponds AS P ON D.pond_id=P.id
    INNER JOIN species AS S ON D.species_id=S_id
GROUP BY P.id
ORDER BY p.id
;