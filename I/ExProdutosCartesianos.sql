--Q1
SELECT * 
FROM PAX 
ORDER BY PaxName;

--Q2
SELECT AirportCode, AirportName
FROM airport
WHERE CountryCode = 'ES'
ORDER BY AirportCode;

--Q3
SELECT route.RouteID, route.Duration
FROM route, airport
WHERE route.Origin = airport.AirportID  AND airport.AirportCode = 'LHR';

--Q4
SELECT route.RouteID, a1.AirportCode AS OriginCode, a2.AirportCode AS DestinationCode
FROM route, airport a1, airport a2
WHERE route.Origin = a1.AirportID 
AND route.Destination = a2.AirportID
ORDER BY a1.AirportCode, a2.AirportCode;

--Q5
SELECT route.RouteID, a1.AirportCode AS OriginCode, a2.AirportCode AS DestinationCode
FROM route, airport a1, airport a2
ORDER BY a1.AirportCode DESC, a2.AirportCode DESC

--Q6
SELECT FlightID as voo, AircraftName as nome
FROM flight as f, aircraft as a, aircrafttype t
WHERE f.AircraftID = a.AircraftID and a.AircraftTypeID = t.AircraftTypeID and t.AircraftName LIKE 'Airbus%'

--Q7
SELECT PaxName, FlightDate, Origin as Origem, Destination as Destination
FROM pax p, route r, flight f, airport a
WHERE p.FlightID = f.FlightID AND f.RouteID = r.RouteID

--Q8
SELECT p.PaxName, p.FlightDate, a1.AirportCode as Origem, a2.AirportCode as Destination
FROM pax p, route r, flight f, airport a1, airport a2 
WHERE p.FlightID = f.FlightID AND f.RouteID = r.RouteID AND a1.AirportID = r.Origin AND a2.AirportID = r.Destination
ORDER BY PaxName

--Q9
SELECT FlightID,AirportCode,MaxSeats
FROM flight f, airport a, route r, flightclass fc
WHERE f.RouteID = r.RouteID AND a.AirportID = r.Destination AND f.FlightID = fc.FlightID and fc.ClassID = '3'
ORDER BY MaxSeats DESC


--Q10
SELECT 
    class.ClassName, 
    flightclass.FlightID, 
    flightclass.MaxSeats, 
    flightclass.BasePrice
FROM 
    class
JOIN 
    flightclass ON class.ClassID = flightclass.ClassID
ORDER BY 
    class.ClassName, 
    flightclass.FlightID, 
    flightclass.BasePrice;
