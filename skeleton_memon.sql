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
	SELECT p.SIN,p.LastName as totalSeniors
	FROM Person p,Passenger a
	WHERE a.pid=p.pid AND YEAR(p.DateOfBirth-date('2019-11-14'))>=65;

-- ++++++++++++++++++++
--  Q2
-- ++++++++++++++++++++
	
	SELECT COUNT(*) as taken
	FROM Person p, Passanger a,Route r, Take t
	WHERE s.RouteID=4 AND t.sin=p.SIN AND t.ShipID=s.ShipID AND p.SIN=a.sin AND YEAR(date('2019-11-14')-p.DateOfBirth)<65 AND YEAR(date('2019-11-14')-p.DateOfBirth)>=14 AND  s.Date=date('2019-09-04')

-- ++++++++++++++++++++
--  Q3.A
-- ++++++++++++++++++++

	SELECT ShipID,Age,Manufacturer
	FROM Ship 
	WHERE Ship.AdvertisingRevenue>10000  

-- ++++++++++++++++++++
--  Q3.B
-- ++++++++++++++++++++

	SELECT DISTINCT p.firstname,p.lastname,i.YearOfService,i.Salary,s.ShipID
	FROM Pilot i, Ship s,Operate o,Person p
	WHERE i.SIN=o.SIN AND s.ShipID=o.ShipID AND p.SIN=i.SIN AND s.AdvertisingRevenue=(SELECT MAX(s1.AdvertisingRevenue) FROM Ship s1)
	

-- ++++++++++++++++++++
--  Q3.C
-- ++++++++++++++++++++

	SELECT DISTINCT RouteID,SUM(s.AdvertisingRevenue) AS TotalRevenue
	FROM Ship s,Route r
	WHERE r.RouteID=s.RouteID
	ORDER BY SUM(s.AdvertisingRevenue) DESC;


-- ++++++++++++++++++++
--  Q4.A
-- ++++++++++++++++++++
	SELECT a.Type,SUM(f.Fee) AS revenue
	FROM Passanger a, Fare f
	WHERE a.Type=f.Type;
	

-- ++++++++++++++++++++
--  Q4.B
-- ++++++++++++++++++++

	SELECT a.Type,SUM(f.Fee) AS revenue
	FROM Passanger a, Fare f
	WHERE a.type=f.type AND SUM(f.fee)>=500;
	

-- ++++++++++++++++++++
--  Q4.C
-- ++++++++++++++++++++
	
	SELECT a.Type,MAX(f.Fee) AS revenue
	FROM Passanger a, Fare f,Take t
	WHERE a.type=f.type AND t.Date=date('2019-09-01') AND t.SIN=a.SIN;
	

-- ++++++++++++++++++++
--  Q5.A
-- ++++++++++++++++++++

	SELECT DISTINCT p.SIN,p.FirstName,p.LastName,YEAR(date('2019-11-14')-p.DateOfBirth) AS Age
	FROM Pilot i,Person p,Infraction n
	WHERE i.SIN=p.SIN AND i.SIN=n.SIN AND sum(n.Demetrit) <=3

-- ++++++++++++++++++++
--  Q5.B
-- ++++++++++++++++++++

	SELECT SUM(n.Demetrit) AS  totalDemerit, SUM(n.Fine) AS totalFine
	From Pilot i,Person P, Infraction n
	WHERE i.SIN=p.SIN AND i.SIN=n.SIN AND SUM(n.Demetrit) >=2
	GROUP BY SUM(n.Demerit),SUM(n.Fine);


-- ++++++++++++++++++++
--  Q6.A
-- ++++++++++++++++++++

	SELECT DISTINCT s1.ShipID
	FROM Ship s1,Ship s2
	WHERE s1.Manufacturer <> s2.Manufacturer;

-- ++++++++++++++++++++
--  Q6.B
-- ++++++++++++++++++++

	SELECT r.RouteID, MAX(count(t.SIN)) AS number_of_times
	FROM Route r,Take t,Ship s
	WHERE s.RouteID=r.RouteID AND t.ShipID=s.ShipID 



-- ++++++++++++++++++++
--  Q6.C
-- ++++++++++++++++++++

	SELECT DISTINCT t.date,MAX(count(t.SIN)) AS trips_taken
	FROM Take t;


-- ++++++++++++++++++++
--  Q7.A
-- ++++++++++++++++++++

	SELECT DISTINCT p.SIN
	FROM Site e,Person p,Ship s,Route r, Stop t,Go g
	WHERE e.SIName LIKE '%library%' AND p.SIN=t.SIN AND t.ShipID=s.ShipID AND r.RouteID=s.RouteID AND s.RouteID=g.RouteID AND  g.SIName=e.SIName;

-- ++++++++++++++++++++
--  Q7.B
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q8
-- ++++++++++++++++++++

	SELECT i.FirstName,i.LastName,i.SIN
	FROM Pilot i,Infraction n
	WHERE i.YearOfService>=5 AND i.Salary >75000 AND i.SIN=n.SIN and SUM(n.Demerit)<9

-- ++++++++++++++++++++
--  Q9
-- ++++++++++++++++++++

	SELECT p.FirstName,p.LastName,h.Number
	FROM Person p, Phone h,Site s, Event e,Route r,Take t,Go g
	WHERE e.EName='Jedi Knight Basketball' AND s.SIName='Jedi Temple' AND p.SIN=h.SIN AND 
	p.SIN=t.SIN AND t.RouteID=4 AND g.RouteID=4 AND g.SIName=s.SIName;


-- ++++++++++++++++++++
--  Q10
-- ++++++++++++++++++++

	SELECT r.RouteID,t.SNAME,sc.ArrivalTime
	FROM Route r,Stop t,Schedule sc,Event e,
	WHERE e.EName='YG 4hunnid Concert' AND e.Time='18:30:00' AND r.RountID=sc.RountID AND sc.StopID=t.StopID AND sc.ArrivalTime BETWEEN '16:00:00' AND '17:00:00'

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- END
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++