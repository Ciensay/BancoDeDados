
--Q1
SELECT * FROM airport WHERE CityName = "London"

--Q2
SELECT * FROM airport WHERE NumTerminals>1

--Q3
SELECT MaxSeats  FROM flightclass WHERE FlightID = 876 AND ClassID = 3

--Q4
SELECT RouteID FROM route WHERE Distance>5000

--Q5
SELECT PaxName FROM pax where FlightID = 652 and ClassID = 3

--Q6
SELECT AirportCode,AirportName FROM airport WHERE CountryCode = "ES"

--Q7
SELECT DepDay,DepTime FROM flightdep WHERE FlightID = 896

--Q8
SELECT NextMaintBegin FROM aircraft WHERE RegNum = "ZX5731"

--Q9
SELECT RegNum FROM aircraft WHERE LastMaintEnd>="2007-04-01" AND LastMaintEnd<="2008-05-20"

--Q10
SELECT RegNum FROM aircraft WHERE AircraftTypeID=617 OR AircraftTypeID=503