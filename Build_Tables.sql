---drop table Traffic 
---drop table PTransLoc
---drop table RoadLinkInfo 
---drop table EnvOzone
---drop table EnvParticulate
---drop table EnvNitrogen
---drop table RoadLink
---drop table MainRoad

--- Group Location 

CREATE TABLE Location
(
    City CHAR(50) PRIMARY KEY,
    Region CHAR(50) NOT NULL, 
	Country CHAR(50) NOT NULL
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE PostCode
(
    Post_Code VARCHAR(15) PRIMARY KEY,
	City CHAR(50) FOREIGN KEY REFERENCES Location(City),
    Easting NUMERIC(19,5), 
	Northing NUMERIC(19,5)
)

--- Data Inserted with MS SQL Server tool

--- Group Road 

CREATE TABLE MainRoad
(
    Road_ID VARCHAR(15) PRIMARY KEY 
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE MainRoad_Jewel
(
    Road_ID VARCHAR(15) FOREIGN KEY REFERENCES MainRoad(Road_ID),
    Post_Code VARCHAR(15) FOREIGN KEY REFERENCES PostCode(Post_Code),
    Constraint Road_ID_Post_Code_ID PRIMARY KEY (Road_ID, Post_Code)	
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE RoadLink
(
	Link_ID VARCHAR(25) PRIMARY KEY,
	Road_ID VARCHAR(15) FOREIGN KEY REFERENCES MainRoad(Road_ID) NOT NULL, 
	Link_Name VARCHAR(25) NOT NULL,
	Link_Start VARCHAR(25) NOT NULL,
	Link_End VARCHAR(25) NOT NULL,
	Link_Length_Mile float  NOT NULL
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE RoadLinkInfo
(
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	Link_Meas_Date VARCHAR(25) NOT NULL,  
	Link_Time_Sec float,
	Link_Speed_MPH float,
	Constraint Road_Link_Info_ID PRIMARY KEY (Link_ID, Link_Meas_Date) 
)

--- Data Inserted with MS SQL Server tool


--- Group Environment

CREATE TABLE EnvNitrogen
(
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	NO2_Date VARCHAR(25) NOT NULL,  
	NO2 float,
	Constraint Nitrogen_ID PRIMARY KEY (Link_ID, NO2_Date)
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE EnvParticulate
(
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	PM10_Date VARCHAR(25) NOT NULL,  
	PM10 float,
	Constraint Particulate_ID PRIMARY KEY (Link_ID, PM10_Date)
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE EnvOzone
(
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	O3_Date VARCHAR(25) NOT NULL,  
	O3 float,
	Constraint O3_ID PRIMARY KEY (Link_ID, O3_Date)
)

--- Data Inserted with MS SQL Server tool

--- Group Transportation

CREATE TABLE Traffic
(
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	AADF_Year VARCHAR(4),  
	Bike int,
	Motorcycle int,
	Car_Taxi int,
	Bus_Coach int,
	LGV_All int,
	HGV_V2_Rigid int,
	HGV_V3_Rigid int,
	HGV_V4_5_Rigid int,
	HGV_V3_4_Artic int,
	HGV_V5_Artic int,
	HGV_V6p_Artic int,
	Constraint Traffic_ID PRIMARY KEY (Link_ID, AADF_Year)
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE PTransLoc
(
    Naptan_Code VARCHAR(30) PRIMARY KEY,
	Link_ID VARCHAR(25) FOREIGN KEY REFERENCES RoadLink(Link_ID),
	Stop_Name VARCHAR(100),
    Stop_Easting NUMERIC(19,5), 
	Stop_Northing NUMERIC(19,5),
	Stop_Type CHAR(10) CHECK (Stop_Type IN ('BCS', 'BCT', 'RSE')), 
	Stop_Status CHAR(10) CHECK (Stop_Status IN ('active', 'inactive')), 
	Stop_Nptg_Ref VARCHAR(10),
	Stop_Direction CHAR(10) NOT NULL CHECK (Stop_Direction IN ('N', 'NE', 'NW','S', 'SE', 'SW', 'E', 'W'))
)

--- Data Inserted with MS SQL Server tool

CREATE TABLE PTransUse
(
	City CHAR(50) FOREIGN KEY REFERENCES Location(City),
	PT_Year VARCHAR(50) NOT NULL, 
	PT_Time VARCHAR(50) NOT NULL,
	PT_Direction VARCHAR(50) CHECK (PT_Direction IN ('INBOUND', 'OUTBOUND')), 
	Pas_Bus int,
	Pas_Rail int,
	Pas_Metro int,
	Pas_Car int,
	Constraint Trans_Use_ID PRIMARY KEY (City, PT_Year, PT_Time, PT_Direction)
)

--- Data Inserted with MS SQL Server tool

select * from EnvNitrogen
select * from EnvOzone
select * from EnvParticulate
select * from Location
select * from MainRoad
select * from MainRoad_Jewel
select * from PostCode
select * from PTransLoc
select * from PTransUse
select * from RoadLink
select * from RoadLinkInfo
select * from Traffic


