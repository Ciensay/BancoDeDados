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

SELECT m.name
FROM movies m
WHERE NOT EXISTS (
    SELECT 1 
    FROM roles r 
    WHERE r.movie_id = m.movie_id
);

SELECT m.name
FROM movies m
WHERE m.movie_id NOT IN (
    SELECT movie_id
    FROM roles
    WHERE movie_id IS NOT NULL
);