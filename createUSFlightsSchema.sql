DROP SCHEMA IF EXISTS USAirlineFlights;
CREATE DATABASE IF NOT EXISTS USAirlineFlights;
use USAirlineFlights;

CREATE TABLE USAirports (
	IATA			VARCHAR(32) NOT NULL PRIMARY KEY,
	Airport			VARCHAR(80),
	CityflightIDflightIDflightID			VARCHAR(32),
	State			VARCHAR(32),
	Country			VARCHAR(32),
	Latitude		FLOAT,
	Longitude		FLOAT);
    
CREATE TABLE Carriers (
	CarrierCode		VARCHAR(32) NOT NULL PRIMARY KEY,
	Description		VARCHAR(120)
);

CREATE TABLE IF NOT EXISTS Flights(
	flightID		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	colYear			SMALLINT,
	colMonth		SMALLINT,
    DayOfMonths		SMALLINT,
	DayOfWeek		SMALLINT,
	DepTime			SMALLINT,
	CRSDepTime		SMALLINT,
	ArrTime			SMALLINT,
	CRSArrTime		SMALLINT,
	UniqueCarrier	VARCHAR(32),
	FlightNum		VARCHAR(32),
	TailNum			VARCHAR(32),
	ActualElapsedTime SMALLINT,
	CRSElapsedTime	SMALLINT,
	AirTime			SMALLINT,
	ArrDelay		SMALLINT,
	DepDelay		SMALLINT,
	Origin			VARCHAR(32),
	Dest			VARCHAR(32),
	Distance		SMALLINT,
	TaxiIn			SMALLINT,
	TaxiOut			SMALLINT,
	Cancelled		BOOLEAN,
	CancellationCode VARCHAR(32),
	Diverted		BOOLEAN,
    
    FOREIGN KEY (Dest)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (Origin)
		REFERENCES USAirports (IATA),
        
	FOREIGN KEY (UniqueCarrier)
		REFERENCES Carriers (CarrierCode)
);
drop table flights;
select * from flights;
/*Exercise 1*/
select count(*) as TOTAL from flights;

/*Exercise 2*/
/*Retard promig de sortida i arribada segons l’aeroport origen.*/
select origin, avg(DepDelay) as 'Departure delay avarage', Dest as 'destiny', avg(ArrDelay) as 'Arrival delay avarage'
from flights
group by origin;

/*Exercise 3*/
/*Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen.
 A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files):
LAX, 2000, 01, 10
LAX, 2000, 02, 30
LAX, 2000, 03, 2
*/
select origin, colYear, colMonth, avg(arrDelay) as 'Arrival delay avarage'
from flights 
group by colMonth;

/*Exercise 4*/
/*Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa consulta que abans i amb el mateix ordre). 
Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat.
		Los Angeles, 2000, 01, retard
Los Angeles, 2000, 02, retard*/
select a.Airport, f.colYear, f.colMonth, avg(arrDelay)  as 'Arrival delay avarage' 
from flights f
left join USAirports a
on f.origin=a.IATA
group by f.colMonth;

/*Exercise 5*/
/*Les companyies amb més vols cancelats. 
A més, han d’estar ordenades de forma que les companyies amb més cancel·lacions apareguin les primeres.*/
/*select UniqueCarrier from flights;*/
select sum(cancelled) as 'Cancelled', UniqueCarrier as 'AirLine' 
from flights
group by UniqueCarrier
order by sum(cancelled) desc;

/*Exercise 6*/
/*L’identificador dels 10 avions que més distància han recorregut fent vols.*/
select UniqueCarrier 'AirLine',  FlightNum, sum(distance) as 'Distance' 
from flights 
group by FlightNum
order by distance desc
limit 0,10;

/*Exercise 7*/
/*Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí
 amb un retràs promig major de 10 minuts.*/
select UniqueCarrier 'AirLine', avg(ArrDelay) 'Arrival delay'
from flights
group by UniqueCarrier
having avg(arrDelay)>10;