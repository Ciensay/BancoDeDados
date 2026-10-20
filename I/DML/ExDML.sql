--Q1

PRAGMA foreign_keys = ON;
INSERT INTO flight (FlightID, RouteID, AircraftID) VALUES (904, 1003, 3223);

SELECT *
FROM  flight
WHERE FlightID = 904;


-- Q2

INSERT INTO aircrafttype (AircraftTypeID, AircraftName) VALUES(787, 'Boeing 787-9');
SELECT *
FROM aircrafttype
WHERE AircraftTypeID = 787;


--Q3

UPDATE stats
SET CurrSeats = CurrSeats + 2
WHERE FlightID = 652 AND FlightDate = '2009-01-20' AND ClassID = 3;
SELECT * 
FROM stats 
WHERE FlightID = 652;


--Q4
UPDATE stats 
SET CurrSeats = CurrSeats + 5, 
    CurrPrice = CurrPrice * 1.2 
WHERE FlightID = 652 AND FlightDate = '2009-01-20' AND ClassID = 2;
SELECT * 
FROM stats 
WHERE FlightID = 652;