--========================
--Batch Request per sec
SELECT * FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%SQL Statistics%';

USE master
SELECT 
session_id,request_id,start_time,status,command,
database_id,user_id,connection_id,blocking_session_id,
wait_type,wait_time,wait_resource,last_wait_type,
transaction_id, sql_handle
FROM sys.dm_exec_requests
ORDER BY start_time;
GO

SELECT 
session_id,request_id,start_time,status,command,
database_id,user_id,connection_id,
total_elapsed_time
FROM sys.dm_exec_requests
ORDER BY total_elapsed_time;
GO


--Finding all currently blocked requests
SELECT session_id, status, blocking_session_id  
    , wait_type, wait_time, wait_resource
    , transaction_id
FROM sys.dm_exec_requests
WHERE status = N'suspended';  
GO

--DISK USAGE
EXEC sp_spaceused;
GO


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



select distinct
convert(varchar(512), b.volume_mount_point) as [volume_mount_point],
convert(varchar(512), b.logical_volume_name) as [logical_volume_name],
convert(decimal(18,1), round(((convert(float, b.available_bytes) / convert(float, b.total_bytes)) * 100),1)) as [percent_free],
convert(bigint, round(((b.available_bytes / 1024.0)/1024.0),0)) as [free_mb],
convert(bigint, round(((b.total_bytes / 1024.0)/1024.0),0)) as [total_mb],
convert(bigint, round((((b.total_bytes - b.available_bytes) / 1024.0)/1024.0),0)) as [used_mb]
from sys.master_files as [a]
CROSS APPLY sys.dm_os_volume_stats(a.database_id, a.[file_id]) as [b];