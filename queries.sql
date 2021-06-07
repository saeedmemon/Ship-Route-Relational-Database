-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- CSC 343: Group Assignment 2
-- Winter 2020 | UTM
-- SKELETON FILE FOR PART I: SQL
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- ***** DO NOT CHANGE THE FORMAT *****
-- ***** YOU MAY ONLY ADD WHERE *****
-- *****  IT INDICATES TO DO SO *****

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- PREAMBLE
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Parter 1's Name: Saeed Memon
-- Partner 1's Student Number: 1003139338
-- Partner 1's UtorID: memonsae

-- Parter 2's Name: Jeong Min Cha
-- Partner 2's Student Number: 1003351222
-- Partner 2's UtorID: chajeong

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BEGIN
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- ++++++++++++++++++++
--  Q1
-- ++++++++++++++++++++

SELECT COUNT(*) AS totalSeniors
FROM Person
WHERE YEAR(date('2019-11-14')) - YEAR(DateOfBirth) >= 65;

-- ++++++++++++++++++++
--  Q2
-- ++++++++++++++++++++

SELECT COUNT(*) as taken
FROM Take, Route, Person
WHERE (Person.SIN=Take.SIN) AND (Person.Occupation = "student") AND (Route.RouteID = 1) AND (Take.Date = date('2019-09-04'));

-- ++++++++++++++++++++
--  Q3.A
-- ++++++++++++++++++++

SELECT ShipID, Age, Manufacturer
FROM Ship
WHERE AdvertisingRevenue > 10000;

-- ++++++++++++++++++++
--  Q3.B
-- ++++++++++++++++++++

SELECT r.FirstName, r.LastName, p.YearsOfService, Q1.ShipID
FROM 
(SELECT ShipID, Age, Manufacturer, AdvertisingRevenue, MAX(AdvertisingRevenue)
        FROM Ship
        GROUP BY ShipID, Age, Manufacturer, AdvertisingRevenue) AS Q1
LEFT JOIN Operate o ON Q1.ShipID = o.ShipID
LEFT JOIN Pilot p ON o.SIN = p.SIN
LEFT JOIN Person r ON p.SIN = r.SIN;

-- ++++++++++++++++++++
--  Q3.C
-- ++++++++++++++++++++

SELECT RouteID, SUM(AdvertisingRevenue) AS TotalRevenue
FROM Ship
GROUP BY RouteID
ORDER BY TotalRevenue DESC;

-- ++++++++++++++++++++
--  Q4.A
-- ++++++++++++++++++++

SELECT Passenger.Type, SUM(Fare.Fee) AS revenue
FROM Fare, Passenger
GROUP BY Passenger.Type;

-- ++++++++++++++++++++
--  Q4.B
-- ++++++++++++++++++++

SELECT Passenger.Type, SUM(Fare.Fee) AS revenue
FROM Fare, Passenger
GROUP BY Passenger.Type
HAVING revenue > 500;

-- ++++++++++++++++++++
--  Q4.C
-- ++++++++++++++++++++

SELECT Passenger.Type, SUM(Fare.Fee) AS revenue
FROM Fare, Passenger, Take
WHERE Take.Date = date('2019-09-01')
GROUP BY Passenger.Type;

-- ++++++++++++++++++++
--  Q5.A
-- ++++++++++++++++++++

SELECT Infraction.SIN, Person.FirstName, Person.LastName, (YEAR(CURDATE()) - YEAR(Person.DateOfBirth)) AS Age
FROM Person, Infraction
GROUP BY Infraction.SIN, Person.FirstName, Person.LastName, Age
HAVING COUNT(Person.SIN) < 3;

-- ++++++++++++++++++++
--  Q5.B
-- ++++++++++++++++++++

SELECT SIN, SUM(Demerit) AS totalDemerit, SUM(Fine) AS totalFine
FROM Infraction
WHERE Demerit >= 2
GROUP BY SIN, Demerit, Fine
ORDER BY Demerit, Fine DESC;

-- ++++++++++++++++++++
--  Q6.A
-- ++++++++++++++++++++

SELECT ShipID, Manufacturer
FROM Ship
WHERE Manufacturer IN (SELECT Manufacturer
FROM Ship
GROUP BY Manufacturer
HAVING COUNT(*) = 1);

-- ++++++++++++++++++++
--  Q6.B
-- ++++++++++++++++++++

SELECT RouteID, COUNT(SIN) AS "number of times"
FROM Take, Ship
WHERE Date = date('2019-09-07')
GROUP BY RouteID;

-- ++++++++++++++++++++
--  Q6.C
-- ++++++++++++++++++++

SELECT Date, COUNT(SIN) AS "trips taken"
FROM Take
GROUP BY Date;

-- ++++++++++++++++++++
--  Q7.A
-- ++++++++++++++++++++

SELECT p.Occupation, COUNT(*) AS occurrences
FROM Person p
INNER JOIN Take t ON p.SIN = t.SIN
INNER JOIN Ship s ON t.ShipID = s.ShipID
INNER JOIN Route r ON s.RouteID = r.RouteID
INNER JOIN Schedule sc ON r.RouteID = sc.RouteID
INNER JOIN Stop as st ON sc.StopID = st.StopID
INNER JOIN Sites as si ON st.SIName = si.SIName
WHERE si.Category = 'Library' AND (sc.Date = date('2019-09-05') OR sc.Date = date('2019-09-06'))
GROUP BY p.Occupation;

-- ++++++++++++++++++++
--  Q7.B
-- ++++++++++++++++++++

SELECT vt.Occupation, sc.Date, vt.occurrences
FROM (
        SELECT p.Occupation, r.RouteID,  COUNT(*) AS occurrences
        FROM Person p
            INNER JOIN Take t ON p.SIN = t.SIN
            INNER JOIN Ship s ON t.ShipID = s.ShipID
            INNER JOIN Route r ON s.RouteID = r.RouteID
            INNER JOIN Go g ON r.RouteID = g.RouteID
            INNER JOIN Sites as si ON g.SIName = si.SIName
        WHERE si.Category = 'Library' 
        GROUP BY p.Occupation, r.RouteID
    ) vt
    INNER JOIN Schedule sc ON vt.RouteID = sc.RouteID
WHERE (sc.Date = date('2019-09-05') OR sc.Date = date('2019-09-06'))
GROUP BY vt.Occupation, sc.Date, vt.occurrences;

-- ++++++++++++++++++++
--  Q8
-- ++++++++++++++++++++

SELECT DISTINCT Person.FirstName, Person.LastName, Infraction.SIN
FROM Pilot, Infraction, Person
WHERE Pilot.YearsOfService > 5
AND Pilot.Salary > 75000
AND Infraction.Demerit < 9;

-- ++++++++++++++++++++
--  Q9
-- ++++++++++++++++++++

SELECT DISTINCT p.FirstName, p.LastName, p.Sex, ph.Number
FROM Person p
    INNER JOIN Phone ph ON p.SIN = ph.SIN
    INNER JOIN Take t ON p.SIN = t.SIN
    INNER JOIN Ship s ON t.ShipID = s.ShipID
    INNER JOIN Route r ON s.RouteID = r.RouteID
    INNER JOIN Schedule sc ON r.RouteID = sc.RouteID
    INNER JOIN Stop st ON sc.StopID = st.StopID
    INNER JOIN Sites si ON si.SIName = st.SIName
    INNER JOIN Event e ON si.SIName = e.SIName
WHERE e.EName = "Jedi Knight Basketball" AND e.SIName = "Jedi Temple" AND sc.RouteID = 4;

-- ++++++++++++++++++++
--  Q10
-- ++++++++++++++++++++

SELECT DISTINCT sc.RouteID, st.SName, sc.ArrivalTime
FROM Schedule sc
    INNER JOIN Stop st ON sc.StopID = st.StopID
    INNER JOIN Sites si ON si.SIName = st.SIName
    INNER JOIN Event e ON si.SIName = e.SIName
WHERE e.EName = "YG 4hunnid Concert" AND sc.ArrivalTime BETWEEN time('16:00:00') AND time('17:00:00');

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- END
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++