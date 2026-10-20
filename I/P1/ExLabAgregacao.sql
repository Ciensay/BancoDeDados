--Q1
SELECT r.RouteID, count(f.FlightID) AS Quant
FROM route r LEFT OUTER JOIN flight f on r.RouteID = f.RouteID
GROUP BY r.RouteID

--Q2

SELECT NULL AS AircraftID, AircraftName
FROM aircrafttype
WHERE AircraftTypeID IN (
    SELECT AircraftTypeID FROM aircrafttype
    EXCEPT
    SELECT AircraftTypeID FROM aircraft
);

SELECT a.AircraftID, at.AircraftName
FROM aircrafttype at LEFT OUTER JOIN aircraft a ON a.AircraftTypeID = at.AircraftTypeID

EXCEPT

SELECT a.AircraftID, at.AircraftName
FROM aircrafttype at JOIN aircraft a ON a.AircraftTypeID = at.AircraftTypeID


SELECT ac.aircraftid, act.AircraftName
FROM aircrafttype act
LEFT OUTER JOIN aircraft ac ON ac.AircraftTypeID = act.AircraftTypeID
WHERE ac.AircraftID IS NULL

--Q3
SELECT act.AircraftName, count(ac.AircraftID) AS Quant
FROM aircrafttype act LEFT OUTER JOIN aircraft ac ON ac.AircraftTypeID = act.AircraftTypeID
GROUP BY act.AircraftName


--Q4
SELECT a.AirportCode, COUNT(r.RouteID) AS Quant
FROM airport a JOIN route r ON a.AirportID = r.Origin
GROUP BY a.AirportCode
HAVING COUNT(r.RouteID) > 2

--Q5
SELECT r.RouteID, o.AirportCode AS FromAirport, d.AirportCode AS ToAirport, f.FlightID, fd.DepTime, fd.DepDay
FROM route r
JOIN airport o ON r.Origin = o.AirportID
JOIN airport d ON r.Destination = d.AirportID
JOIN flight f ON f.RouteID = r.RouteID
JOIN flightdep fd ON fd.FlightID = f.FlightID


--Q6
SELECT  FlightID
FROM flightdep
EXCEPT
SELECT FlightID
FROM flightdep
WHERE DepDay =1
ORDER BY FlightID

SELECT DISTINCT FlightID
FROM flightdep
WHERE flightid NOT IN (
  SELECT flightid
  FROM flightdep
  WHERE depday = 1
 )
ORDER BY FlightID

--Q7


SELECT o.AirportName AS FromAirport, d.AirportName AS ToAirport, c.ClassName
FROM route r
JOIN airport o ON r.Origin = o.AirportID
JOIN airport d ON r.Destination = d.AirportID
JOIN flight f ON f.RouteID = r.RouteID
JOIN flightclass fc ON fc.FlightID = f.FlightID
JOIN class c ON fc.ClassID = c.ClassID
WHERE fc.BasePrice IN (
SELECT MIN(BasePrice)
FROM flightclass
);

--Q8
SELECT o.AirportName AS FromAirport, d.AirportName AS ToAirport, s.FlightDate, c.ClassName
FROM stats s
JOIN flight f ON f.FlightID = s.FlightID
JOIN route r ON r.RouteID = f.RouteID
JOIN airport o ON r.Origin = o.AirportID
JOIN airport d ON r.Destination = d.AirportID
JOIN class c ON s.ClassID = c.ClassID
WHERE s.CurrPrice IN(
    SELECT MAX(s.CurrPrice)
    FROM stats
);


SELECT o.AirportName AS FromAirport, d.AirportName AS ToAirport, s.FlightDate, c.ClassName
FROM route r
JOIN airport o ON r.Origin = o.AirportID
JOIN airport d ON r.Destination = d.AirportID
JOIN flight f ON f.RouteID = r.RouteID
JOIN stats s ON s.FlightID = f.FlightID
JOIN class c ON c.ClassID = s.ClassID
WHERE s.CurrPrice IN (
  SELECT MAX(currprice)
  FROM stats
)

SELECT a1.AirportName AS FromAirport, a2.AirportName AS ToAirport, s.FlightDate, c.ClassName
FROM ((((((route r
JOIN airport a1 ON r.Origin = a1.AirportID)
JOIN airport a2 ON r.Destination = a2.AirportID)
JOIN flight f ON r.RouteID = f.RouteID)
JOIN flightclass fc ON f.FlightID = fc.FlightID)
JOIN class c ON c.ClassID = fc.ClassID)
JOIN stats s ON (s.FlightID = f.FlightID AND s.ClassID = c.ClassID))
GROUP BY a1.AirportName, a2.AirportName, s.FlightDate, c.ClassName
HAVING MAX(s.CurrPrice) = (
    SELECT MAX(CurrPrice)
    FROM stats
);




-- PARTE 2!!!


--Q9

SELECT g.name, COUNT(*) as QUANT
FROM  genres g
JOIN movies_genres mg ON g.genre_id = mg.genre_id
--JOIN movies m ON m.movie_id = mg.movie_id
GROUP BY g.genre_id



--Q10

SELECT m.name, m.year
FROM movies m
WHERE m.year IN (
    SELECT MIN(year)
    FROM movies
);

SELECT m.name, m.year
FROM movies m
WHERE m.year = MIN(m.year)




--Q11

SELECT d.first_name, d.last_name
FROM directors d
JOIN movies_directors md ON d.director_id = md.director_id
JOIN movies m ON md.movie_id = m.movie_id
WHERE m.rank IN (
    SELECT MAX(rank)
    FROM movies
);

--Q12
SELECT a.first_name, a.last_name, COUNT(r.role) AS QUANT
FROM actors a
JOIN roles r ON  r.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING COUNT(r.role) > 2



SELECT a.first_name, a.last_name, COUNT(r.role) AS Quant
FROM actors a
JOIN roles r ON r.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING COUNT(r.role) > 2

--Q13

SELECT m.name
FROM  movies m
LEFT JOIN roles r ON  m.movie_id = r.movie_id
WHERE r.movie_id IS NULL;

SELECT m.name
FROM movies m
WHERE m.movie_id NOT IN (
  SELECT movie_id
  FROM roles
)

--Q14
SELECT m.year, AVG(m.rank) AS MEDIA
FROM movies m
GROUP BY m.year
ORDER BY MEDIA DESC


--Q15
SELECT SUM(m.rank) AS SOMA
FROM movies m
WHERE m.year = 1994


--Q16
SELECT d.first_name, d.last_name, g.name, dg.prob
FROM directors d
JOIN directors_genres dg ON dg.director_id = d.director_id
JOIN genres g ON g.genre_id = dg.genre_id
WHERE dg.prob IN(
    SELECT MAX(dga.prob)
    FROM directors_genres dga
    WHERE dga.director_id = d.director_id
);

SELECT d.first_name, d.last_name, g.name, dg.prob
FROM directors d
JOIN directors_genres dg On dg.director_id = d.director_id
JOIN genres g ON dg.genre_id = g.genre_id
WHERE dg.prob IN (
  SELECT MAX(prob)
  FROM directors_genres
  GROUP BY director_id
  HAVING director_id = d.director_id
)


--Q17
SELECT a.gender, COUNT(a.actor_id) AS QUANT
FROM actors a
GROUP BY a.gender

SELECT g.name, COUNT(a.actor_id) AS Quant
FROM actors a
JOIN roles r ON r.actor_id = a.actor_id
JOIN movies m ON m.movie_id = r.movie_id
JOIN movies_genres mg ON mg.movie_id = m.movie_id
JOIN genres g ON g.genre_id = mg.genre_id
GROUP BY g.name







SELECT g.name, COUNT(a.actor_id) AS Quant
FROM actors a
JOIN roles r ON r.actor_id = a.actor_id
JOIN movies m ON m.movie_id = r.movie_id
JOIN movies_genres mg ON mg.movie_id = m.movie_id
JOIN genres g ON g.genre_id = mg.genre_id
GROUP BY g.name

SELECT a.gender, COUNT(a.actor_id) AS Quant
FROM actors a
GROUP BY a.gender


--Q18

SELECT b.first_name
FROM actors b
GROUP BY b.first_name
ORDER BY COUNT(b.first_name) DESC
LIMIT 1;




SELECT a.first_name
FROM actors a
GROUP BY a.first_name
HAVING COUNT(a.actor_id) = (
    SELECT MAX(QTD)
    FROM (
        SELECT COUNT(actor_id) AS QTD
        from actors
        GROUP BY first_name
    )
)


SELECT first_name, COUNT(first_name)
FROM actors
GROUP BY first_name
HAVING COUNT(first_name) = (
                    SELECT MAX(nome_pop)
                    FROM (SELECT COUNT(first_name) AS nome_pop
                    FROM actors
                    GROUP BY first_name) t1);

