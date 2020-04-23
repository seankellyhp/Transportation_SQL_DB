
CREATE USER readonlylog FROM LOGIN readonlylog ; 
EXEC sp_addrolemember 'db_datareader', readonlylog; 

CREATE USER adminlog FROM LOGIN adminlog ; 
EXEC sp_addrolemember 'db_securityadmin', adminlog;

CREATE USER managerlog FROM LOGIN managerlog ; 
EXEC sp_addrolemember 'db_accessadmin', managerlog;

CREATE USER userlog FROM LOGIN userlog ; 
EXEC sp_addrolemember 'db_datawriter', userlog;