
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

