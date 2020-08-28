-----------------------------------------------------------------------------------------
--Only used for COMP6240 students in S2 2020
--Please enter your SQL queries to Question 1.1-1.10 
--Please input your UID here: U1234567
------------------------------------------------------------------------------------------

-- Q1.1
SELECT COUNT(*)
FROM movie m
WHERE m.major_genre = 'comedy'
AND m.production_year = '1994';

-- Q1.2
SELECT COUNT(*)
FROM director d LEFT JOIN writer w
ON d.title = w.title
AND d.production_year = w.production_year
WHERE d.id = w.id;

-- Q1.3
SELECT r.id, COUNT(*)
FROM role r
GROUP BY r.id, r.title, r.production_year
HAVING COUNT(*) > 1;

-- Q1.4
SELECT r.title, r.production_year, COUNT(*)
FROM restriction r
WHERE r.description = 'PG'
GROUP BY r.title, r.production_year
HAVING COUNT(*) > 1;

-- Q1.5
With WriterName AS
(	SELECT p.id AS id,
		p.first_name AS first_name,
		p.last_name AS last_name,
		w.title AS title,
		w.production_year AS production_year
	FROM person p RIGHT JOIN writer w
	ON p.id = w.id),
NameWriteMovie AS
(	SELECT wm.id AS id,
		wm.first_name AS first_name,
		wm.last_name AS last_name,
		m.country AS country
	FROM WriterName wm LEFT JOIN movie m
	ON wm.title = m.title
	AND wm.production_year = m.production_year)
SELECT nwm.id AS id,
	MAX(nwm.first_name) AS first_name,
	MAX(nwm.last_name) AS last_name
FROM NameWriteMovie nwm
GROUP BY nwm.id, nwm.country
HAVING COUNT(*) = 2;

-- Q1.6
SELECT COUNT(*)
FROM director d LEFT JOIN role r
ON d.title = r.title
AND d.production_year = r.production_year
WHERE NOT d.id = r.id;

-- Q1.7
With AwardDirector AS
(	SELECT d.id AS id,
		d.title AS title,
		d.production_year AS production_year,
		da.year_of_award AS year_of_award 
	FROM director_award da LEFT JOIN director d
	ON da.title = d.title
	AND da.production_year = d.production_year
	WHERE da.result = 'won')
SELECT ad.id, ad.year_of_award
FROM AwardDirector ad LEFT JOIN writer_award w
ON ad.id = w.id
WHERE ad.year_of_award = w.year_of_award
AND w.result = 'won';

-- Q1.8
With crewName AS
(	SELECT c.id, p.first_name, p.last_name,
		concat(c.title, c.production_year) AS movie
	FROM crew c LEFT JOIN person p
	ON c.id = p.id
	ORDER BY c.id),
crewsum AS
(	SELECT cn.id,
		MAX(cn.first_name) AS first_name,
		MAX(cn.last_name) AS last_name,
		COUNT(DISTINCT cn.movie) AS sumnum
	FROM crewName cn
	GROUP BY cn.id
	ORDER BY COUNT(DISTINCT cn.movie) DESC),
maxnum AS
(	SELECT MAX(ss.sumnum) AS maxnum
	FROM crewsum ss)
SELECT cw.id, cw.first_name, cw.last_name
FROM crewsum cw INNER JOIN maxnum mn
ON cw.sumnum = mn.maxnum;

-- Q1.9










-- Q1.10











----------------------------------------------------------------
-- End of your answers
-----------------------------------------------------------------
