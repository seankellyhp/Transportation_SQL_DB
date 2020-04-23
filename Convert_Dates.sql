/****** Object:  Table [dbo].[RoadLinkInfo]    Script Date: 1/13/2019 12:24:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoadLinkInfo2](
	[Link_ID] [varchar](25) NOT NULL,
	[Link_Meas_Date] [varchar](25) NOT NULL,
	[Link_Time_Sec] [float] NULL,
	[Link_Speed_MPH] [float] NULL,
 CONSTRAINT [Road_Link_Info_ID2] PRIMARY KEY CLUSTERED 
(
	[Link_ID] ASC,
	[Link_Meas_Date] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RoadLinkInfo2]  WITH CHECK ADD FOREIGN KEY([Link_ID])
REFERENCES [dbo].[RoadLink] ([Link_ID])
GO

INSERT RoadLinkInfo2 SELECT * FROM RoadLinkInfo;
select * from RoadLinkInfo2


ALTER TABLE RoadLinkInfo2 ADD Link_Meas_Date_d Date;

update RoadLinkInfo2
set Link_Meas_Date_d = convert(datetime, convert(varchar(30), Link_Meas_Date), 101)

select Link_Meas_Date_d from RoadLinkInfo2

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'RoadLinkInfo2' AND 
     COLUMN_NAME = 'Link_Meas_Date_d'

select min(Link_Meas_Date_d) from RoadLinkInfo2 as MinDate

--- Change to date 03 

select convert(datetime, convert(varchar(30), NO2_Date), 101) from EnvNitrogen


ALTER TABLE EnvOzone ADD O3_Date_d Date;
update EnvOzone
set O3_Date_d = convert(datetime, convert(varchar(30), O3_Date), 101)

select O3_Date_d from EnvOzone
select * from EnvOzone

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'EnvOzone' AND 
     COLUMN_NAME = 'O3_Date_d';

select min(O3_Date_d) from EnvOzone

--- Nitrogen Date 

ALTER TABLE EnvNitrogen ADD NO2_Date_d Date;
update EnvNitrogen
set NO2_Date_d = convert(datetime, convert(varchar(30), NO2_Date), 101)

select NO2_Date_d from EnvNitrogen

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'EnvNitrogen' AND 
     COLUMN_NAME = 'NO2_Date_d';

select max(NO2_Date_d) from EnvNitrogen

select * from EnvNitrogen

--- Particulate Date

select * from EnvParticulate

alter table EnvParticulate drop column PM10_Date_d
ALTER TABLE EnvParticulate ADD PM10_Date_d date;

update EnvParticulate
set PM10_Date_d = convert(date, convert(varchar(30), PM10_Date), 101)

select * from EnvParticulate

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'EnvParticulate' AND 
     COLUMN_NAME = 'PM10_Date_d';

select max(PM10_Date_d) from EnvParticulate

---



