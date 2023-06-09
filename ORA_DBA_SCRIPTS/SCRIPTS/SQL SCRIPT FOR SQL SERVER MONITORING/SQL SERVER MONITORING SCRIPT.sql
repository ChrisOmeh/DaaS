SELECT @@VERSION
SELECT @@CONNECTIONS

SELECT * FROM sys.databases
where name NOT IN ('master', 'tempdb','model','msdb');

USE AdventureWorksSales
SELECT COUNT(*) FROM sys.databases;


SELECT * FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%SQL Statistics%' AND counter_name='Batch Requests/sec';   

USE master
SELECT 
start_time,
session_id,
request_id,
db_name(database_id) as [database_name],
user_id,
connection_id,
blocking_session_id,
command,
status,
wait_type,
wait_time,
wait_resource,
last_wait_type,
transaction_id, 
sql_handle
FROM sys.dm_exec_requests
WHERE database_id NOT IN (1, 2,3,4)
ORDER BY start_time;
GO

--==========================
--TOTAL ELAPSED TIME
--==========================
USE master
SELECT 
start_time,
session_id,
request_id,
db_name(database_id) as [database_name],
user_id,
connection_id,
status,
command,
total_elapsed_time/1000  as total_elapsed_time_sec
FROM sys.dm_exec_requests
ORDER BY total_elapsed_time DESC;
GO

--======================================
--LAST ELAPSED TIME
--=======================================
--LAST ELAPSED TIME
select
    creation_time,
    last_elapsed_time  as [last_elapsed_time_microsec],
    last_worker_time  as[last_worker_time_microsec],
    DATEDIFF(MILLISECOND, creation_time, getdate())  as  [since_creation_time_ms],

    convert(varchar(20), DATEDIFF(DAY, 0, CONVERT(VARCHAR,DATEADD(ms,last_elapsed_time,0),113))) + ' days ' +
    CONVERT(VARCHAR,DATEADD(ms,last_elapsed_time,0),114)    [last_elapsed_time_format],

    convert(varchar(20), DATEDIFF(DAY, 0, CONVERT(VARCHAR,DATEADD(ms,last_worker_time,0),113))) + ' days ' +
    CONVERT(VARCHAR,DATEADD(ms,last_worker_time,0),114)     [last_worker_time_format],

    convert(varchar(20), DATEDIFF(DAY, creation_time, getdate())) + ' days ' +
    CONVERT(VARCHAR,DATEADD(ms,DATEDIFF(MILLISECOND, creation_time, getdate()),0),114)  [since_creation_time]

from sys.dm_exec_query_stats
order by last_elapsed_time desc


--=========================
--DISK USAGE
--==========================
USE master
EXEC sp_spaceused;
GO

USE master
select distinct
convert(varchar(512), b.volume_mount_point) as [volume_mount_point],
convert(varchar(512), b.logical_volume_name) as [logical_volume_name],
convert(decimal(18,1), round(((convert(float, b.available_bytes) / convert(float, b.total_bytes)) * 100),1)) as [percent_free],
convert(bigint, round(((b.available_bytes / 1024.0)/1024.0),0)) as [free_mb],
convert(bigint, round(((b.total_bytes / 1024.0)/1024.0),0)) as [total_mb],
convert(bigint, round((((b.total_bytes - b.available_bytes) / 1024.0)/1024.0),0)) as [used_mb]
from sys.master_files as [a]
CROSS APPLY sys.dm_os_volume_stats(a.database_id, a.[file_id]) as [b];
GO

USE master
exec master.dbo.xp_fixeddrives;
GO

--====================================
--CPU usage %
--====================================
SELECT * FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%Resource Pool Stats%';-- AND counter_name='CPU usage %';

USE master
SELECT 
pool_id,
name,
statistics_start_time,
total_cpu_usage_ms/1000 as [total_cpu_usage_sec],
cache_memory_kb
FROM sys.dm_resource_governor_resource_pools;



SELECT TOP 10 s.session_id,
           r.status,
           r.cpu_time,
           r.logical_reads,
           r.reads,
           r.writes,
           r.total_elapsed_time / (1000 * 60) 'Elaps M',
           SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
           ((CASE r.statement_end_offset
                WHEN -1 THEN DATALENGTH(st.TEXT)
                ELSE r.statement_end_offset
            END - r.statement_start_offset) / 2) + 1) AS statement_text,
           COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
           + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
           r.command,
           s.login_name,
           s.host_name,
           s.program_name,
           s.last_request_end_time,
           s.login_time,
           r.open_transaction_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
WHERE r.session_id != @@SPID
ORDER BY r.cpu_time DESC


SELECT TOP 20
    qs.sql_handle,
    qs.execution_count,
    qs.total_worker_time AS Total_CPU,
    total_CPU_inSeconds = --Converted from microseconds
    qs.total_worker_time/1000000,
    average_CPU_inSeconds = --Converted from microseconds
    (qs.total_worker_time/1000000) / qs.execution_count,
    qs.total_elapsed_time,
    total_elapsed_time_inSeconds = --Converted from microseconds
    qs.total_elapsed_time/1000000,
    st.text,
    qp.query_plan
FROM
    sys.dm_exec_query_stats AS qs
        CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
        CROSS apply sys.dm_exec_query_plan (qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC;

--============================
--USED MEMORY
--============================
USE AdventureWorksSales
select  * from sys.dm_os_sys_memory;

--==================================


SELECT * FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%Buffer Manager%';
--
select * from SYS.DM_IO_PENDING_IO_REQUESTS;


select [status],
max(total_cpu_usage_ms) as MAX_TOTAL_CPU_USAGE,
max(total_scheduler_delay_ms) as MAX_TOTAL_SCHEDULER_DELAY
from SYS.DM_OS_SCHEDULERS
GROUP BY [status]
order by MAX_TOTAL_CPU_USAGE desc;


--=============================
select * from   SYS.DM_OS_WAIT_STATS; 

select CAST(create_date as date) as created_date,
database_id,
UPPER(name) as database_name,
compatibility_level,
user_access_desc,
state_desc,
recovery_model_desc,
log_reuse_wait_desc
from sys.databases;

select DISTINCT(name) from sys.all_objects;  --

select * from  sys.server_principals; 

select * from sys.database_principals;
select * from sys.sysusers;
select * from sys.sysoledbusers;

select  distinct(name)  from sys.all_objects
order by name asc;
