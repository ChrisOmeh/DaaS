--================================== ALL SQL DB OBJECTS
SELECT * FROM sys.all_objects;

--===============================
SELECT * FROM sys.dm_exec_query_memory_grants;

--==========================================
SELECT * FROM sys.database_files;

--=================================
select CAST(create_date as date) as created_date,
database_id,
UPPER(name) as database_name,
compatibility_level,
user_access_desc,
state_desc,
recovery_model_desc,
log_reuse_wait_desc
from sys.databases;

select * from sys.databases;

select * from sys.master_files;

select @@VERSION
--Microsoft SQL Server 2016 (SP1) (KB3182545) - 13.0.4001.0 (X64)   Oct 28 2016 18:17:30   Copyright (c) Microsoft Corporation  
--Enterprise Edition: Core-based Licensing (64-bit) on Windows Server 2012 R2 Standard 6.3 <X64> (Build 9600: ) 

SELECT compatibility_level FROM sys.databases
where compatibility_level >=100;


--========================
select * from sys.sysusers;
select * from sys.sql_logins;
select * from sys.database_principals;
select * from sys.syslogins;
select * from sys.server_principals;
select db_name(database_id) from sys.database_recovery_status;

select * from sys.all_objects 
where name like '%recovery%';
--==============================

SELECT name AS Login_Name, type_desc AS Account_Type
FROM sys.server_principals 
WHERE TYPE IN ('U', 'S', 'G')
and name not like '%##%'
ORDER BY name, type_desc

--===============================
SELECT loginname as LOGIN_NAME,
CAST(createdate as date) as CREATED_DATE
from sys.syslogins;

select * from sys.syslogins;
select * FROM sys.server_principals;

--===================================
SELECT loginname as LOGIN_NAME,
type_desc as LOGIN_TYPE,
CAST(create_date as date) as CREATED_DATE,
case when is_disabled =1
then 'DISABLED'
else
'ENABLED'
END as ACCOUNT_STATUS
FROM sys.server_principals,sys.syslogins
ORDER BY LOGIN_NAME, ACCOUNT_STATUS;

--==============================================
--SQL CONDITIONAL  STATEMENT
DECLARE @MATH INT, @ENG INT, @CHEM INT, @PHY INT
SET @MATH = 80;
SET @ENG = 70;
SET @CHEM = 75;
SET @PHY = 85;

IF @MATH >70
BEGIN
PRINT 'CONGRATULATIONS YOU PASSED MATH'
END
ELSE
BEGIN
PRINT'YOU FAILED MATH'
END

IF @ENG >70
BEGIN
PRINT 'CONGRATULATIONS YOU PASSED MATH'
END
ELSE
BEGIN
PRINT'YOU FAILED MATH'
END

IF @CHEM >70
BEGIN
PRINT 'CONGRATULATIONS YOU PASSED MATH'
END
ELSE
BEGIN
PRINT'YOU FAILED MATH'
END

IF @PHY >70
BEGIN
PRINT 'CONGRATULATIONS YOU PASSED MATH'
END
ELSE
BEGIN
PRINT'YOU FAILED MATH'
END

--=============================================================
DECLARE @MATHS INT, @ENGG INT, @CHEMM INT, @PHYY INT
SET @MATHS = 80;
SET @ENGG = 70;
SET @CHEMM = 75;
SET @PHYY = 85;
IF (@MATHS >=50 AND @ENGG >= 50 AND @CHEMM >=50 AND @PHYY >=50)
BEGIN
	DECLARE @PERCENTAGE FLOAT
	SET @PERCENTAGE = ((@MATHS+@ENGG+@CHEMM+@PHYY)*100) / 300
	PRINT CONCAT('YOUR PERCENTAGE SCORE IS:', @PERCENTAGE)
END
ELSE
BEGIN
	PRINT "YOU DON'T HAVE A PERCENTAGE SCORE"
END


--=============================================
--DISK VOLUME 
SELECT db_name(f.database_id) AS [DATABASE NAME], 
f.database_id AS [DATABASES ID], 
f.file_id AS [FILE ID], 
volume_mount_point[Disk], 
CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) AS [TOTAL SPACE SIZE(GB)], 
CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) AS [AVAILABLE SPACE SIZE(GB)],
CAST(CAST(available_bytes AS FLOAT)/CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) *100 AS [PCT FREE SPACE(%)]
FROM sys.master_files AS f  
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id)
ORDER BY [PCT FREE SPACE(%)] DESC;


SELECT DISTINCT 
    CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
    volume_mount_point [Disk], 
    file_system_type [File System], 
    logical_volume_name as [Logical Drive Name], 
    CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) AS [Total Size in GB], ---1GB = 1073741824 bytes
    CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) AS [Available Size in GB],  
    CAST(CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) * 100 AS [Space Free %] 
FROM sys.master_files 
CROSS APPLY sys.dm_os_volume_stats(database_id, file_id)
ORDER BY [Space Free %] DESC;


--======================================================
SELECT * FROM sys.dm_os_sys_info;
select * from sys.dm_os_windows_info;
select * from sys.dm_server_services;


select * from sys.all_objects
where name like '%recovery%';

select * from sys.databases
where database_id not in (1,2,3,4) AND log_reuse_wait_desc = 'LOG_BACKUP'
order by name;

--===========================================================
select * from sys.security_predicates;
select * from sys.dm_tran_global_recovery_transactions;

--======================================
SELECT *
FROM sys.inventory.Storage
ORDER BY percent_free_space;

--======================================
--Adventureworks database
USE [AdventureWorksSales]
select COUNT(*) from [dbo].[Product];

declare @col varchar
set @col = 
(select TOP 1 Color
				from [dbo].[Product]
				where [StandardCost] = (select MAX([StandardCost]) from [dbo].[Product]));
select Name
from [dbo].[Product]
where Color = @col;


select Name 
from [dbo].[Product]
where Color = (select TOP 1 Color
				from [dbo].[Product]
				where [StandardCost] = (select MAX([StandardCost]) from [dbo].[Product]))



select TOP 5 * from [dbo].[Product];
select TOP 5 * from [dbo].[ProductCategory];

select distinct(year(cast([ModifiedDate] as date))) from [dbo].[SalesOrder];
select distinct(month(cast([ModifiedDate] as date))) from [dbo].[SalesOrder];
select distinct(day(cast([ModifiedDate] as date))) from [dbo].[SalesOrder];


select TOP 5 * FROM [dbo].[SalesOrder];

SELECT * FROM sys.traces;


--=======================================================
--FIND DB USERS, LOGINS AND PRIVILEGES
--=======================================================

USE MASTER
(SELECT DISTINCT p.name AS [loginname] ,
p.type ,
p.type_desc ,
CONVERT(VARCHAR(10),p.create_date ,101) AS [created],
CONVERT(VARCHAR(10),p.modify_date , 101) AS [update],
case when p.is_disabled = 1 then 'Disabled'
            else 'Enabled' end as status,
case when s.sysadmin = 1 then 'Admin'
            else 'Not Admin' end as Administrative_privilege
FROM sys.server_principals p
JOIN sys.syslogins s ON p.sid = s.sid
JOIN sys.server_permissions sp ON p.principal_id = sp.grantee_principal_id
WHERE p.type_desc IN ('SQL_LOGIN', 'WINDOWS_LOGIN', 'WINDOWS_GROUP')
-- Logins that are not process logins
AND p.name NOT LIKE '##%'
AND p.name NOT LIKE 'NT SERVICE%'
-- Logins that are sysadmins or have GRANT CONTROL SERVER
AND (s.sysadmin = 1)
)
UNION ALL
(SELECT DISTINCT p.name AS [loginname] ,
p.type ,
p.type_desc ,
CONVERT(VARCHAR(10),p.create_date ,101) AS [created],
CONVERT(VARCHAR(10),p.modify_date , 101) AS [update],
case when p.is_disabled = 1 then 'Disabled'
            else 'Enabled' end as status,
case when s.sysadmin = 1 then 'Admin'
            else 'Not Admin' end as Administrative_privilege
FROM sys.server_principals p
JOIN sys.syslogins s ON p.sid = s.sid
JOIN sys.server_permissions sp ON p.principal_id = sp.grantee_principal_id
RIGHT JOIN sys.database_principals dp ON p.name COLLATE DATABASE_DEFAULT = dp.name COLLATE DATABASE_DEFAULT
WHERE p.type_desc IN ('SQL_LOGIN', 'WINDOWS_LOGIN', 'WINDOWS_GROUP')
-- Logins that are not process logins
AND p.name NOT LIKE '##%'
-- Logins that are sysadmins or have GRANT CONTROL SERVER
--AND (s.sysadmin = 1 OR sp.permission_name = 'CONTROL SERVER')
)

--===================================
--MASTER COUNT DB OBJECTS
--===================================
SELECT COUNT(*) FROM SYS.all_columns;
SELECT COUNT(*) FROM SYS.all_objects;
SELECT COUNT(*) FROM SYS.all_parameters;
SELECT COUNT(*) FROM SYS.all_views;

--===================================
--ALL DB VIEWS
--==================================
SELECT * FROM SYS.all_views
WHERE name LIKE '%sp%';


--====SQL SERVER CDC=====
USE AdventureWorksSales
SELECT	name AS object_name   
		,SCHEMA_NAME(schema_id) AS schema_name  
		,type_desc  
		,is_ms_shipped  
FROM sys.objects 
WHERE is_ms_shipped= 1 AND SCHEMA_NAME(schema_id) = 'cdc';

select TOP 5 * FROM [dbo].[Product];
select TOP 5 * FROM [dbo].[ProductCategory];

