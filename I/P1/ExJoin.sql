
--Q1
SELECT RouteID, Origin, Destination
FROM route
INNER JOIN airport
ON Origin = AirportID AND (AirportCode = 'LHR' or AirportCode = 'AMS')

--Q2
SELECT RouteID, Origin, Destination
FROM route
INNER JOIN airport
ON Origin = AirportID AND (AirportCode = 'LHR')
UNION
SELECT RouteID, Origin, Destination
from route
INNER JOIN airport
ON Origin = AirportID AND (AirportCode = 'AMS')

--Q3
SELECT RouteID, o.AirportCode as Origem, d.AirportCode as Destino
FROM route r
INNER JOIN airport o
ON o.AirportID = r.Origin
INNER JOIN airport d
ON d.AirportID = r.Destination
ORDER BY o.AirportCode, d.AirportCode

--Q4
SELECT f.*, fd.DepTime
FROM flight f
INNER JOIN flightdep fd ON f.FlightID = fd.FlightID
ORDER BY f.FlightID

--Q5
SELECT f.FlightID, fc.ClassID
FROM flight f
LEFT JOIN flightclass fc ON f.FlightID = fc.FlightID

--Q6 PODE SER USAR DISTINCT PARA NAO REPETIR INFORMACOES
SELECT f.*
FROM flight f
INNER JOIN pax p ON f.FlightID = p.FlightID

--Q7
SELECT f.FlightID, p.PaxName
FROM flight f
LEFT JOIN pax p ON f.FlightID = p.FlightID
ORDER BY f.FlightID, p.PaxName

--Q8
SELECT f.FlightID
FROM flight f
EXCEPT
SELECT p.FlightID
FROM pax p

--Q9
SELECT f.FlightID, o.AirportCode AS Origem, d.AirportCode AS Destino
FROM flight f
JOIN route r ON f.RouteID = r.RouteID
JOIN airport o ON r.Origin = o.AirportID
JOIN airport d ON r.Destination = d.AirportID
WHERE f.FlightID IN (
    SELECT f.FlightID
    FROM flight f
    EXCEPT
    SELECT p.FlightID
    FROM pax p
);

