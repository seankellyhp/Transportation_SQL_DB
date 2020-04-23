--- Daily Averages for Environmental Numbers 

CREATE VIEW O3_Daily as
select avg(O3) as 'Avg_O3', O3_Date_d as 'Date'
from EnvOzone
Group by O3_Date_d

CREATE VIEW NO2_Daily as
select avg(NO2) as 'Avg_NO2', NO2_Date_d as 'Date'
from EnvNitrogen
Group by NO2_Date_d

Create view PM10_Daily as
select avg(PM10) as 'AVG_PM10', PM10_Date_d as 'Date'
from EnvParticulate
Group by PM10_Date_d

Create view Env_Daily as
SELECT O3_Daily.Date as Measure_Day, 
AVG_O3, 
AVG_NO2, 
AVG_PM10
FROM O3_Daily
INNER JOIN NO2_Daily
    on O3_Daily.Date = NO2_Daily.Date
INNER JOIN PM10_Daily
    on NO2_Daily.Date = PM10_Daily.Date

select * from Env_Daily 
order by Measure_Day


--- See which columns are the primary keys and foreign keys in db 
--- For Admin
SELECT name, object_id, type, create_date, modify_date from Sys.Objects WHERE (Type='PK' or Type = 'f') 
and schema_id = 1 
order by Type

--- Areas Roads with most traffic 

select AADF_Year, count(Link_ID) as Num_Measure from Traffic 
group by AADF_Year

Select top 15 Link_Name, Car_Taxi
from RoadLink  
inner join 
 (Select Link_ID, sum(Car_Taxi) as Car_Taxi
    from  Traffic 
	where AADF_Year = '2000'
	group by Link_ID) Traffic 
on Traffic.Link_ID= RoadLink.Link_ID 
order by Car_Taxi desc

--- See which roads are in a set of postal codes, such as those part of the Clean Air Zone
SELECT *
FROM MainRoad_Jewel
WHERE Post_Code IN ('B4 7WR', 'B4 7WN', 'B4 7WF', 'B4 7WE', 'B4 7SE', 'B4 7SD', 'B4 7PP', 'B4 7HY')

declare @cleanair table (code varchar(4000))
insert into @cleanair values ('B4 7WR'), ('B4 7WN'), ('B4 7WF'), ('B4 7WE'), ('B4 7SE'), ('B4 7SD'), ('B4 7PP'), ('B4 7HY') 
select * 
from MainRoad_Jewel
where Post_Code IN (select code from @cleanair) 

--- Summary stats of Hourly Environmental 

select 'Nitrogen' as Category, 
round(min(NO2), 2) as Min, round(max(NO2), 2) as Max, 
round(avg(NO2), 2) as AVG, round(STDEV(NO2), 2) as SD, 
min(NO2_Date_d) as Min_Date, 
max(NO2_Date_d) as Max_Date
from EnvNitrogen;
select 'Ozone' as Category, 
round(min(O3), 2) as Min, 
round(max(O3), 2) as Max, round(avg(O3), 2) as AVG, 
round(STDEV(O3), 2) as SD, 
min(O3_Date_d) as Min_Date, 
max(O3_Date_d) as Max_Date 
from EnvOzone;
select 'Particulate' as Category, 
round(min(PM10), 2) as Min, round(max(PM10), 2) as Max, 
round(avg(PM10), 2) as AVG, round(STDEV(PM10), 2) as SD, 
min(PM10_Date_d) as Min_Date, 
max(PM10_Date_d) as Max_Date 
from EnvParticulate;


select PT_Time, PT_Direction,  avg(Pas_Bus) as Bus_Avg, avg(Pas_Rail) as Rail_Avg, avg(Pas_Metro) as Metro_Avg, avg(Pas_Car) as Car_Avg
from PTransUse
group by PT_Direction, PT_Time


select Road_ID, Link_Name, round(Link_Length_Mile, 2) as Avg_Length, round(Avg_Speed, 2) as Avg_Speed_MPH
from RoadLink 
inner join
(select Link_ID, avg(Link_Speed_MPH) as Avg_Speed
from RoadLinkInfo group by Link_ID) roadtime 
on roadtime.Link_ID = RoadLink.Link_ID 

select Link_Name, round(Link_Length_Mile, 2) as Length_Miles, Road_ID, Link_Start, Link_End, round(Num_Stops, 2) as Num_Bus_Stops
from RoadLink 
inner join
(select Link_ID, count(Stop_Name) as Num_Stops
from PTransLoc group by Link_ID) stops
on stops.Link_ID = RoadLink.Link_ID 
order by Length_Miles desc

select Link_Name, round(Link_Length_Mile, 2) as Length_Miles, Road_ID, Link_Start, Link_End, round(Num_Stops, 2) as Num_Bus_Stops
from RoadLink 
inner join
(select Link_ID, count(Stop_Name) as Num_Stops
from PTransLoc group by Link_ID) stops
on stops.Link_ID = RoadLink.Link_ID 
order by Length_Miles desc


--- Create Indexes 

CREATE NONCLUSTERED INDEX Idx_O3_Meas ON EnvOzone(O3 asc)
CREATE NONCLUSTERED INDEX Idx_NO2_Meas ON EnvNitrogen(NO2 asc)
CREATE NONCLUSTERED INDEX Idx_PM10_Meas ON EnvParticulate(PM10 asc)

CREATE NONCLUSTERED INDEX Idx_Cars ON Traffic(Car_Taxi asc)
CREATE NONCLUSTERED INDEX Idx_Tr_Link ON Traffic(Link_ID asc)

CREATE NONCLUSTERED INDEX Idx_Roadlink_Road ON RoadLink(Road_ID asc)

CREATE NONCLUSTERED INDEX Idx_PTUse_Dir_Time ON PTransUse(PT_Direction asc, PT_Time)
CREATE NONCLUSTERED INDEX Idx_PTUse_Pas_Car ON PTransUse(Pas_Car asc)


