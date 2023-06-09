=======================================================
ORACLE SCRIPTS
=======================================================

1. To unlock account
ALTER USER account ACCOUNT UNLOCK;
ALTER USER USERNAME ACCOUNT UNLOCK; ------Unlock user account

2. To reset pssword.
ALTER USER user_name IDENTIFIED BY new_password; 

3. Reset password and Unlock User Account
ALTER USER USERNAME IDENTIFIED BY NEW_PASSWORD ACCOUNT UNLOCK;  -------Account pwd reset and Account unlock.

4. Create User in ORACLE
CREATE USER USERNAME IDENTIFIED BY User_Password; 
CREATE USER A224360 IDENTIFIED BY DEcember__2022;
GRANT CREATE SESSION TO USER A224360;

select name from dba_services;
select * from v$listener_network;
=============================================================================
=======================GRANTING USERS PRIVILEGES SCRIPT======================
=============================================================================
select 'GRANT EXECUTE ON '||owner||'.'||object_name||' TO user;'
from all_objects
where owner = 'MISUSER'
and object_type='FUNCTION';

5. Kill sessions
kill session for session_id
kill all -u session_name/session_id

6. Running process in Linux
ps -a
ps -u
ps -x 
ps -aux

Finding a complex Process
pgrep <options> <pattern>

<option>
-l: List both the process names and the PIDs
-n: Return process that is newest
-o: Return process that is oldest
-u: Only find processes that belong to a specific user.
-x: Only find a process that matches a specific pattern
kill -9 PID
killl -15 PID 

7. DISABLE USER IN ORACLE
alter user USER_ID account lock password expire;


---SQL Server Connection String:---
Data Source=10.52.1.44;Initial Catalog=MyDB;Trusted_connection=false;Integrated Security=false;User Id=someone;Password=passw


--===========================
--DBA_OBJECTS
--===========================
USE ungrdbox
SELECT OWNER ,
OBJECT_NAME ,
OBJECT_ID ,
OBJECT_TYPE ,
CREATED ,
LAST_DDL_TIME ,
STATUS ,
NAMESPACE ,
SHARING ,
ORACLE_MAINTAINED ,
APPLICATION ,
DUPLICATED ,
SHARDED
FROM DBA_OBJECTS
WHERE STATUS = 'INVALID'
ORDER BY CREATED ASC;

select * FROM dba_users
where username = 'EBANKUSER';

select * from ALL_TABLES
where rownum <=5 and TABLE_NAME = 'MOBILEAPP_SMART_LOAN';

--RDBOX TABLES
SELECT  * FROM ALL_TABLES
WHERE ROWNUM <=5 AND TABLE_NAME = 'CMP_VENDOR';

SELECT * FROM ALL_TABLES
WHERE ROWNUM <=5 AND TABLE_NAME = 'RBX_TRANS_FEES_CONFIG';

--==============================
--DBA_USERS
--==============================
USE ungrdbox
SELECT 
USERNAME,
USER_ID,
ACCOUNT_STATUS,
DEFAULT_TABLESPACE,
TEMPORARY_TABLESPACE,
LOCAL_TEMP_TABLESPACE,
CREATED,
PROFILE,
ORACLE_MAINTAINED,
PASSWORD_CHANGE_DATE
FROM DBA_USERS
WHERE USERNAME NOT IN ('SYS','SYSTEM')
ORDER BY ACCOUNT_STATUS ASC;

=====GETTING AND DROPPING DBLINK================
SELECT DBMS_METADATA.GET_DDL('DB_LINK',a.db_link,a.owner) 
FROM dba_db_links a;

======RESTORE DB IN SQL SERVER=============
RESTORE DATABASE [DB_NAME] WITH RECOVERY


======ORACLE SCRIPT TO FIND RUNNING SESSIONS===================
select * from gv$process where addr In (select creator_addr from gv$session where sid=5806 and serial#=29171);

--==================================
--DBA_TABLESPACE
--==================================
SELECT * FROM DBA_TABLESPACES
WHERE TABLESPACE_NAME NOT IN ('SYSTEM', 'SYSAUX','USERS');

select df.tablespace_name "Tablespace",
totalusedspace "Used MB",
(df.totalspace - tu.totalusedspace) "Free MB",
df.totalspace "Total MB",
round(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace))
"Pct. Free"
from
(select tablespace_name,
round(sum(bytes) / 1048576) TotalSpace
from dba_data_files
group by tablespace_name) df,
(select round(sum(bytes)/(1024*1024)) totalusedspace, tablespace_name
from dba_segments
group by tablespace_name) tu
where df.tablespace_name = tu.tablespace_name 
order by "Pct. Free";

SELECT * FROM DBA_OBJECTS
WHERE OBJECT_NAME LIKE '%JOBS%';

SELECT * FROM V$RECOVERY_FILE_DEST; --V$RECOVERY_FILE_DEST, V_$RECOVERY_FILE_DEST

=================================================
CHECK DB TABLE SIZE
=================================================
select a.owner, a.segment_name as TBL_INDEX, a.GB, b.table_name
from (
   select
      owner,
      segment_name,
      bytes/1024/1024/1024 GB
   from
      dba_segments
   where
      segment_type IN ('INDEX') -- ('TABLE', 'INDEX')
   order by
      bytes/1024/1024/1024 desc) a, dba_indexes b
where
    a.segment_name = b.index_name and
   rownum <= 1000 and a.OWNER in ('ODS_DBA','STG_HIST','STG_OPS','STG_SRC', 'STG_WORK','ODS_CLIREC_USR')
   ORDER BY a.gb desc;
   
select * from dba_indexes


select
   OWNER, SEGMENT_NAME AS TABLE_NAME, GB AS SIZE_IN_GB
from (
   select
      owner,
      segment_name,
      round(bytes/1024/1024/1024, 4) GB
   from
      dba_segments
   where
      segment_type = 'TABLE'
   order by
      bytes/1024/1024/1024 desc)
where
   rownum <= 1000;
   
--================================================================
--DBA USERS
SELECT USER_ID, USERNAME, DEFAULT_TABLESPACE,
CREATED,PROFILE,ACCOUNT_STATUS FROM DBA_USERS
ORDER BY USERNAME, ACCOUNT_STATUS;

--================================================================
--DBA OBJECT STATUS
SELECT OWNER,OBJECT_TYPE, 
OBJECT_NAME,CREATED,STATUS
FROM DBA_OBJECTS
WHERE STATUS = 'INVALID'
ORDER BY OWNER ASC;

--==============================================
--DBA SEQUENCE STATUS
SELECT SEQUENCE_OWNER,SEQUENCE_NAME,
LAST_NUMBER,MAX_VALUE,CYCLE_FLAG,
(CAST((CAST(LAST_NUMBER AS FLOAT)/ CAST(MAX_VALUE AS FLOAT)) AS DECIMAL(18,10)) * 100) AS PERCENTAGE_USAGE
FROM DBA_SEQUENCES
WHERE SEQUENCE_NAME LIKE '%CUSTOM%' AND CYCLE_FLAG = 'N';
--CAST(CAST(LAST_NUMBER AS FLOAT)/ CAST(MAX_VALUE AS FLOAT) AS DECIMAL(18,2)) * 100 AS [PERCENTAGE_USAGE]

--========================================================
SELECT * DUMP(MAX_VALUE) from DBA_SEQUENCES;

select count(*) from dba_objects;
select username from dba_users
where username LIKE 'A%';


--===================================
--DB REPLICATION STATUS CHECK
--====================================
SELECT * from v$database;
select min(fhscn) from x$kcvfh;

SELECT 
CURRENT_SCN, 
DATABASE_ROLE, 
SWITCHOVER_STATUS,
GUARD_STATUS as GAP_STATUS
from v$database;

--==========================================================
--DB TRANSACTIONS
--==========================================================
SELECT XID AS "txn id", XIDUSN AS "undo seg", XIDSLOT AS "slot", STATUS AS "txn status"
FROM V$TRANSACTION;

SELECT * FROM V$TRANSACTION;

--==================================
--USER SESSIONS
--=================================
SELECT * FROM V$SESSION
WHERE ROWNUM <=5;

SELECT USERNAME,SID, SERIAL#, STATUS, SERVER
FROM V$SESSION
WHERE USERNAME = 'REDBOX' AND STATUS = 'INACTIVE';

SELECT COUNT(*) FROM V$SESSION;
SELECT DISTINCT(USERNAME) FROM V$SESSION;


select s.sid
      ,s.serial#
      ,s.username
      ,s.machine
      ,s.status
      ,s.lockwait
      ,t.used_ublk
      ,t.used_urec
      ,t.start_time
from v$transaction t
inner join v$session s on t.addr = s.taddr
order by START_TIME DESC;

=======================================
FIND LOCKED SESSSIONS MAIN
==================================-===
select
b.sid, b.serial#,b.inst_id,b.machine,b.sql_exec_start,
d.start_time,c.owner,c.object_name,b.program,b.client_info,
b.status session_status,d.status transaction_status,b.state,
b.event, b.wait_time, b.seconds_in_wait
from
gv$locked_object a ,
gv$session b,
dba_objects c,
gV$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr 
--and c.owner not in ('SYS')
and b.username is not null 
--and b.username not in ('SYS','SYSTEM')
--and ((b.sql_exec_start <  (sysdate - 1/24)) )
order by d.start_time asc;

-KILL THE SESSION
alter system kill session '10,123,@45645' immediate;  ---first number is SID and second is Serial Number


--================================
ORACLE TRANSACTIONS
---===============================
----Find the uncommitted or incomplete transaction in Oracle
Query with V$transaction give result which transaction is not commited yet.

set lines 250
column start_time format a20
column sid format 999
column serial# format 999999
column username format a10
column status format a10
column schemaname format a10

select t.start_time,s.sid,s.serial#,s.username,s.status,s.schemaname,
s.osuser,s.process,s.machine,s.terminal,s.program,s.module,to_char(s.logon_time,'DD/MON/YY HH24:MI:SS') logon_time
from v$transaction t, v$session s
where s.saddr = t.ses_addr
order by start_time;

---Find the SQL statement for uncommitted transaction in Oracle

SELECT S.SID, S.SERIAL#, S.USERNAME, S.OSUSER, S.PROGRAM, S.EVENT
  ,TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') 
  ,TO_CHAR(T.START_DATE,'YYYY-MM-DD HH24:MI:SS') 
  ,S.LAST_CALL_ET, S.BLOCKING_SESSION, S.STATUS
  ,( 
    SELECT Q.SQL_TEXT 
    FROM V$SQL Q 
    WHERE Q.LAST_ACTIVE_TIME=T.START_DATE 
    AND ROWNUM<=1) AS SQL_TEXT 
FROM V$SESSION S, 
  V$TRANSACTION T 
WHERE S.SADDR = T.SES_ADDR;

----Check your current session has uncommitted transaction if return one then it has uncommitted transaction

SELECT COUNT(*)
       FROM v$transaction t, v$session s, v$mystat m
      WHERE t.ses_addr = s.saddr
        AND s.sid = m.sid
        AND ROWNUM = 1;

--===================================================
--ORACLE DATABASE DICTIONARY
--===================================================
SELECT * FROM DICTIONARY
WHERE TABLE_NAME LIKE '%x$kcvfh%';

--ORDER BY TABLE_NAME;

SELECT file_name from dba_data_files;

select * from dba_data_files;

--=======================================
select open_mode, database_role, switchover_status from V$database
where ROWNUM <=2;

--====================================DATA GAUARD===================
SELECT name, value, datum_time, time_computed FROM V$DATAGUARD_STATS
WHERE name like 'apply lag';


======ORACLE DBA_REGISTERY========
select COMP_ID, COMP_NAME, VERSION, STATUS from dba_registry;

select count(*) from dba_objects
where status = 'INVALID';


=====SGA AND PGA IN ORACLE DATABASE=======
select PGA_ALLOCATED from DBA_HIST_ACTIVE_SESS_HISTORY
order by PGA_ALLOCATED DESC;

select name,value 
from v$parameter 
where name in ('memory_max_target','memory_target','sga_max_size',
'pga_aggregate_target','pga_aggregate_limit','shared_pool_size',
'large_pool_size','java_pool_size','db_cache_size','streams_pool_size')
ORDER BY value desc;

select name,value from v$parameter where name in ('memory_max_target','memory_target','sga_max_size',
'pga_aggregate_target','pga_aggregate_limit','shared_pool_size','large_pool_size','java_pool_size','db_cache_size','streams_pool_size');

=======ORACLE TIMEZONE VERSION=======
SELECT * FROM v$timezone_file;


SELECT TZNAME, TZABBREV 
FROM V$TIMEZONE_NAMES
ORDER BY TZNAME, TZABBREV;

SELECT UNIQUE TZNAME
FROM V$TIMEZONE_NAMES;


SELECT * FROM V$TRANSACTION
WHERE STATUS='ACTIVE';


SELECT tz_version FROM registry$database;

SELECT * FROM v$timezone_file;


======GRANT PRIVILEGES TO DB USERS=====
======GRANT INSERT ON [TABLE] CUSTOM.FI_BULK_RATE_MOD TO 'MISUSER'=======
GRANT INSERT ON TABLE_NAME TO USER;
GRANT INSERT ON [TABLE]  TO USER
----------------------------------------------------
REVOKE INSERT ON CUSTOM.FI_BULK_RATE_MOD FROM USER_NAME;


==================FIND LOCKED USERS SESSIONS==========================
SELECT a.session_id, a.oracle_username, a.os_user_name,
b.owner "OBJECT OWNER", b.object_name, b.object_type, a.locked_mode
FROM (SELECT object_id, session_id, oracle_username, os_user_name,
locked_mode
FROM v$locked_object) a,
(SELECT object_id, owner, object_name, object_type
FROM dba_objects) b
WHERE a.object_id = b.object_id;


SELECT a.object_id, a.session_id, substr(b.object_name, 1, 40)
FROM v$locked_object a, dba_objects b
WHERE a.object_id = b.object_id
AND b.object_name like 'SYS%'
ORDER BY b.object_name;

=====Query to Check Failed Jobs in Oracle Database.=======

select JOB,LAST_DATE,THIS_DATE,NEXT_DATE,BROKEN,FAILURES,WHAT from dba_jobs where failures>0;

select count(*) from dba_jobs where FAILURES>0;

---Check status of user scheduled job-----
SELECT to_char(log_date, 'DD-MON-YY HH24:MM:SS') TIMESTAMP, job_name,
  job_class, operation, status FROM USER_SCHEDULER_JOB_LOG
  WHERE job_name = 'JOB2' ORDER BY log_date;
  
  
SELECT job_name, job_class, operation, status FROM USER_SCHEDULER_JOB_LOG;


select owner as schema_name,
       job_name,
       job_style,
       case when job_type is null 
                 then 'PROGRAM'
            else job_type end as job_type,  
       case when job_type is null
                 then program_name
                 else job_action end as job_action,
       start_date,
       case when repeat_interval is null
            then schedule_name
            else repeat_interval end as schedule,
       last_start_date,
       next_run_date,
       state
from sys.all_scheduler_jobs
order by owner,
         job_name;


======Find locked sessions=======
 
SELECT a.session_id, a.oracle_username, a.os_user_name,
b.owner "OBJECT OWNER", b.object_name, b.object_type, a.locked_mode
FROM (SELECT object_id, session_id, oracle_username, os_user_name,
locked_mode
FROM v$locked_object) a,
(SELECT object_id, owner, object_name, object_type
FROM dba_objects) b
WHERE a.object_id = b.object_id;

===Alternative with object name

SELECT a.object_id, a.session_id, substr(b.object_name, 1, 40)
FROM v$locked_object a, dba_objects b
WHERE a.object_id = b.object_id
AND b.object_name like 'SYS%'
ORDER BY b.object_name;
 

====Check for dead locks=====
select * from v$lock where request !=0;
 

====Killing the blocking session=====
select * from v$lock where type='TX' and id1='4718628' and id2='755268';
 

=======Another alternative to find locked sessions query========
SELECT lo.session_id AS sid,
s.serial#,
NVL(lo.oracle_username, '(oracle)') AS username,
o.owner AS object_owner,
o.object_name,
Decode(lo.locked_mode, 0, 'None',
1, 'Null (NULL)',
2, 'Row-S (SS)',
3, 'Row-X (SX)',
4, 'Share (S)',
5, 'S/Row-X (SSX)',
6, 'Exclusive (X)',
lo.locked_mode) locked_mode,
lo.os_user_name,
s.status
FROM v$locked_object lo
JOIN dba_objects o ON o.object_id = lo.object_id
JOIN v$session s ON lo.session_id = s.sid
--WHERE s.status = 'INACTIVE'
ORDER BY 1, 2, 3, 4;
 
--MY MAIN
select s.username,s.sid,s.serial#,s.last_call_et/60 mins_running,q.sql_text from v$session s 
join v$sqltext_with_newlines q
on s.sql_address = q.address
 where status='ACTIVE'
and type <>'BACKGROUND'
and last_call_et> 60
order by sid,serial#,q.piece;

select s.username,s.sid,s.serial#,round(s.last_call_et/3600) mins_running,q.sql_text from v$session s 
join v$sqltext_with_newlines q
on s.sql_address = q.address
 where status='ACTIVE'
and type <>'BACKGROUND'
and last_call_et> 60
order by sid,serial#,q.piece;

select s.INST_ID,s.sid,s.serial#,s.username,s.machine,s.status,s.last_call_et/60/60 as "Minutes",
s.sql_id,s.program from gv$session s where s.type='USER' AND s.status='ACTIVE' AND s.last_call_et>600
order by s.last_call_et/60/60 desc;

select
b.sid, b.serial#,b.inst_id,b.sql_exec_start,d.start_time,c.owner,c.object_name,b.program,b.client_info,b.status session_status,d.status transaction_status,b.state,b.event, b.wait_time, b.seconds_in_wait
from
gv$locked_object a ,
gv$session b,
dba_objects c,
gV$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr 
--and c.owner not in ('SYS')
and b.username is not null 
--and b.username not in ('SYS','SYSTEM')
--and ((b.sql_exec_start <  (sysdate - 1/24)) )
order by d.start_time asc;

===Kill locked session====
ALTER SYSTEM KILL SESSION 'sid,serial# @instance ID' immediate;
select 'alter system kill session ''' ||sid|| ',' || serial#|| ''' immediate;' from gv$session where program like 'HXFER%';
alter system kill session 'sid,serial# @instance ID';

select * from dba_lock;

==Another alternative to find locked sessions query====

SELECT
c.sid,
substr(object_name,1,20) OBJECT,
c.username,
substr(c.program,length(c.program)-20,length(c.program)) image,
DECODE(b.type,
'MR', 'Media Recovery',
'RT', 'Redo Thread',
'UN', 'User Name',
'TX', 'Transaction',
'TM', 'DML',
'UL', 'PL/SQL User Lock',
'DX', 'Distributed Xaction',
'CF', 'Control File',
'IS', 'Instance State',
'FS', 'File Set',
'IR', 'Instance Recovery',
'ST', 'Disk Space Transaction',
'TS', 'Temp Segment',
'IV', 'Library Cache Invalidation',
'LS', 'Log Start or Switch',
'RW', 'Row Wait',
'SQ', 'Sequence Number',
'TE', 'Extend Table',
'TT', 'Temp Table',
b.type) lock_type,
DECODE(b.lmode,
0, 'None', /* Mon Lock equivalent */
1, 'Null', /* NOT */
2, 'Row-SELECT (SS)', /* LIKE */
3, 'Row-X (SX)', /* R */
4, 'Share', /* SELECT */
5, 'SELECT/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
to_char(b.lmode)) mode_held,
DECODE(b.request,
0, 'None', /* Mon Lock equivalent */
1, 'Null', /* NOT */
2, 'Row-SELECT (SS)', /* LIKE */
3, 'Row-X (SX)', /* R */
4, 'Share', /* SELECT */
5, 'SELECT/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
to_char(b.request)) mode_requested
FROM sys.dba_objects a, sys.v_$lock b, sys.v_$session c WHERE
a.object_id = b.id1 AND b.sid = c.sid AND OWNER NOT IN ('SYS','SYSTEM');



====Another alternative to find locked sessions query=====

  SELECT lo.session_id,
         lo.oracle_username,
         lo.os_user_name,
         lo.process,
         do.object_name,
         DECODE (lo.locked_mode,
                 0, 'None',
                 1, 'Null',
                 2, 'Row Share (SS)',
                 3, 'Row Excl (SX)',
                 4, 'Share',
                 5, 'Share Row Excl (SSX)',
                 6, 'Exclusive',
                 TO_CHAR (lo.locked_mode))
             mode_held
    FROM v$locked_object lo, dba_objects do
   WHERE lo.object_id = do.object_id
ORDER BY 1, 5



=====ARCHIVING TABLE IN FINACLE=======
create table tbaadm.mcd_09JAN2023 AS select * from tbaadm.mcd;


--then 

delete from tbaadm.mcd where commodity_code='OT'

commit;


=====RUN ORACLE(FINANCLE) PACKAGES========
BEGIN    

	MISUSER.STE_MAIN_PKG.MONTHLY_STATEMENT_QUERIES();  
	COMMIT;
END; 

BEGIN  
  
	MISUSER.STE_MAIN_PKG.MONTHLY_LOAN_STATEMENT_QUERIES();  
	COMMIT;
END;

 
 
 
===RESOLVING RESOLVABLE GAP AND LOG_SWITCH_GAP IN ORACLE DATABASE===



======INCREASING SQL SERVER DB DATAFILE=======
ALTER DATABASE [NewDatabase]
MODIFY FILE
(NAME = 'NewDatabase_log',
SIZE = 200MB,
FILEGROWTH = 1MB)


=======CHECK PROCEDURES IN ORACLE DATABASE=======
SELECT * FROM USER_PROCEDURES
WHERE ROWNUM <=2;

SELECT * FROM ALL_PROCEDURES
WHERE OWNER = 'MISUSER' AND OBJECT_NAME = 'ISRM_PKG';-- AND ROWNUM<=2;

SELECT * FROM DBA_PROCEDURES
WHERE OWNER = 'MISUSER' AND OBJECT_NAME = 'ISRM_PKG';


SELECT * FROM USER_OBJECTS
WHERE OBJECT_NAME = 'ISRM_PKG';


========ADDING A DATAFILE TO ORACLE DATABASE TABLESPACE=========
asmcmd  ----Automatic Storage Manager Command Prompt

ALTER TABLESPACE TABLESPACE_NAME ADD DATAFILE
SIZE 28GB AUTOEXTEND ON NEXT 1GB MAXSIZE UNLIMITED,
SIZE 28GB AUTOEXTEND ON NEXT 1GB MAXSIZE UNLIMITED,
SIZE 28GB AUTOEXTEND ON NEXT 1GB MAXSIZE UNLIMITED;  ----This adds 3 datafiles to the tablespace.

ALTER TABLESPACE REDBOXTBS_DATA ADD DATAFILE SIZE 31G AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;

ALTER TABLESPACE UNDOTBS2 ADD DATAFILE SIZE 28G AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;

+DATA/PNGFIB/DATAFILE/undotbs1.1005.1049289575 to 31
+DATA/PNGFIB/DATAFILE/undotbs1.2881.1055497975 to 31

Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs1.1005.1049289575' resize 31G;
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs1.2881.1055497975' resize 31G;

Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2886.1055497887' resize 31G;
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2977.1055497661' resize 31G;
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2882.1055497955' resize 31G;
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2884.1055497921' resize 31G;
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2888.1055497853' resize 31G;	
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2963.1055497819' resize 31G;	
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2966.1055497783' resize 31G;	
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs2.2969.1055497743' resize 31G;	
Alter database datafile '+DATA/PNGFIB/DATAFILE/undotbs1.2978.1055497655' resize 31G;	

+DATA/PNGFIB/DATAFILE/undotbs1.2978.1055497655



====================Mongodb connection string===============
mongodb://A226547:STanbic_1234#@pngmobiledb02v:27017/?directConnection=true&authMechanism=DEFAULT&readPreference=secondaryPreferred&authSource=stanbic

mongodb://<user>:<password>@pngmobiledb02v:27017/?directConnection=true&authMechanism=DEFAULT&readPreference=secondaryPreferred&authSource=stanbic
STanbic_1234#

===============CHECK ORACLE DATABASE SERVICES STATUS============
sudo systemctl status oracle-database

sudo systemctl status oracle_database_name

======DB LINK=============
--Create A dblink
CREATE DATABASE LINK LINK_NAME
CONNECT TO DB_USERNAME
IDENTIFIED BY DB_USERNAME'S_PASSWORD
USING 'SERVICE_NAME';

--DROP PUBLIC DATABASE LINK EBANKING_LINK; 
CREATE PUBLIC DATABASE LINK EBANKING_LINK
CONNECT TO APPLOGIN
IDENTIFIED BY applogin
USING '(DESCRIPTION =    
(ADDRESS = (PROTOCOL = TCP)(HOST = 10.234.206.141)(PORT = 1521))    
(CONNECT_DATA =    (SERVER = DEDICATED)    (SERVICE_NAME = ungrdbox)))';

SELECT DB_LINK, USERNAME, HOST FROM ALL_DB_LINKS;
--DBA_DB_LINKS - All DB links defined in the database
--ALL_DB_LINKS - All DB links the current user has access to
--USER_DB_LINKS - All DB links owned by current user

DESC DBA_DB_LINKS;

SELECT * FROM DBA_DB_LINKS;

SELECT * FROM USER_DB_LINKS;


--set up the link:

exec sp_addlinkedserver  @server='10.10.0.10\MyDS';

--set up the access for remote user, example below:

exec sp_addlinkedsrvlogin  '10.10.0.10\MyDS', 'false', null, 'adm', 'pwd';

--see the linked servers and user logins:

exec sp_linkedservers;

select * from sys.servers;

select * from  sys.linked_logins;

--run the remote query:

select * from [10.10.0.10\MyDS].MyDB.dbo.TestTable;

--drop the linked server and the created login users (adm/pwd)

exec sp_dropserver '10.10.0.10\MyDS', 'droplogins'; -- drops server and logins




===PROFILE ON CYBERARK=====
10.234.18.75
10.234.17.83

12.1 not 19.

line 2 to 8 should come under oda

Security control standards on jump server
Jobs that kill long running sessions that in Oracle.
Grafana

Disbaling users on database after 30 days of inactivity.

17.15 is old datastore
timeline regarding dates


=====EXECUTE JOBS====================
DESC MISUSER.REDBOX_REVERSAL_JOB;

DECLARE 
SYS.DBMS_SCHEDULER varchar2(25);
BEGIN
  SYS.DBMS_SCHEDULER.STOP_JOB
    (job_name   => 'MISUSER.REDBOX_REVERSAL_JOB'
    ,force      => FALSE);
END;


DESC MISUSER.REDBOX_REVERSAL_JOB;
begin
  dbms_scheduler.stop_job( job_name => 'MISUSER.REDBOX_REVERSAL_JOB');
end;


DESC MISUSER.REDBOX_REVERSAL_JOB;
begin
  dbms_scheduler.stop_job( job_name => 'MISUSER.REDBOX_REVERSAL_JOB');
end;
EXEC DBMS_SCHEDULER.STOP_JOB (job_name => 'JOB_NAME');


===CHECK COUNT AND ACTIVE SESSIONS=======
SELECT name, value, type,DESCRIPTION
FROM v$parameter
WHERE name = 'sessions';

--The number of sessions currently active
SELECT COUNT(*)
FROM v$session




---------------------------------------------------
File Type 	           Where to Find Statistics 
---------------------------------------------------
Database Files -------- V$FILESTAT, V$SYSTEM_EVENT, V$SESSION_EVENT
 
Log Files ------------ V$SYSSTAT, V$SYSTEM_EVENT, V$SESSION_EVENT
 
Archive Files ------  V$SYSTEM_EVENT, V$SESSION_EVENT
 
Control Files -----  V$SYSTEM_EVENT, V$SESSION_EVENT

SELECT NAME, PHYRDS, PHYWRTS
FROM V$DATAFILE df, V$FILESTAT fs
WHERE df.FILE# = fs.FILE#;


--===================================
ORACLE RESOURCES LIMITS
=======================================
SELECT name, value, type,DESCRIPTION FROM v$parameter WHERE name = 'sessions';

SELECT * FROM v$resource_limit;
select * from v$spparameter;

select resource_name,current_utilization, limit_value from v$resource_limit 
where resource_name in ('sessions','processes','transactions') order by resource_name;

SELECT name, value, type,DESCRIPTION FROM v$parameter where name in ('sessions','processes','transactions') order by name;

processes=X

session = (1.5 * PROCESSES) + 22

transactions = sessions * 1.1


======SQL COMMAND LINE(SQLcl)=======================
sql mekus/password@oracle:1521/racdb1

info table_or_dictionary to see detail info. eg

info v$database
info v$parameter
info v$parameter2
info v$spparameter
info v$system_parameter2


set sqlformat;
set markup csv on;

=========================================================
=======================ADRCI=======================
=========================================================
show homes;
show alert;

select SHORTP_POLICY, LONGP_POLICY from ADR_CONTROL;  ---This show ADR rentention policy
/u01/app/oracle/diag/rdbms
/u01/app/oracle/diag/rdbms/pngrdbox/pngrdbox1:

SHORT RENTENTION policy is used for traces and core dumps
LONG RENTENTION is used for incident and alert logs

PURGE -age 1440 -type ALERT
PURGE -age 1440 -type TRACE

===MODIFY SPFILE LOCATION=====
svrctl modify database -d database_name -spfile path_to_spfile

svrctl config database ---shows database running in the RAC.

======================================
====GENERATE ORACLE AWR=============
======================================
select output 
from table(dbms_workload_repository.awr_report_html(3998855182, 1, 21655, 21656));

select output 
from table(dbms_workload_repository.awr_report_text(3998855182, 1, 21655, 21656)); --3998855182

select dbid from v$database; --to find dbid 4202697316

select snap_id,
       begin_interval_time
       end_interval_time
from dba_hist_snapshot
order by begin_interval_time desc; --to find snap_id  18012 18013

SQL script for getting AWR Report on RAC database:
SQL>@$ORACLE_HOME/rdbms/admin/awrgrpt.sql

SQL script for getting AWR Report for  single instance:
SQL>@$ORACLE_HOME/rdbms/admin/awrrpt.sql

SQL script for getting ASH Report on RAC database:
SQL>@$ORACLE_HOME/rdbms/admin/ashrpti.sql

SQL script for getting ASH Report for single Instance:
SQL>@$ORACLE_HOME/rdbms/admin/ashrpt.sql

SQL script for getting ADDM Report on RAC database:
SQL>@$ORACLE_HOME/rdbms/admin/addmrpti.sql

SQL script for getting ADDM Report for single instance:
SQL>@$ORACLE_HOME/rdbms/admin/addmrpt.sql

Alert Log of the same period above – Only send trim of the 24 hour within EOM period. Not all the large
alertlog
SQL>@$diagnostic_dest/diag/dbname/SID/trace/alert_SID.log


Optionally collect and review latest orachk output
- Download latest Orachk - Health Checks for the Oracle Stack(Doc ID 1268927.2)
$ orachk –a -o v

--Gather Database dictionary statistics. To gather stats run below:
exec DBMS_STATS.GATHER_DICTIONARY_STATS;

--Gather database Fixed Object statistics
execute dbms_stats.gather_fixed_objects_stats;


--Consider Gathering fresh statistics for the Application schemas
EXEC DBMS_STATS.GATHER_SCHEMA_STATS
('<schema_name>');
Or
BEGIN
DBMS_STATS.GATHER_TABLE_STATS('<schema_nam
e>', '<table_name>');
END;
/
You can add more stats gathering options to go
more granular as desired.


=====================================================
ORACLE USERS ROLE AND PRIVILEGES
=====================================================
select * from 
((dba_tab_privs d 
inner join dba_sys_privs s
on d.GRANTEE = s.GRANTEE)
inner join dba_role_privs rl
on d.GRANTEE = rl.GRANTEE)
where d.GRANTEE = 'USERNAME_HERE';


select al.table_name,al.owner,al.tablespace_name,t.grantee, r.granted_role,t.privilege from ((ALL_TABLES al
left join dba_tab_privs t
on al.owner = t.owner)
left join dba_role_privs r
on t.GRANTEE = r.GRANTEE)
where t.grantee = 'A204505' and r.granted_role = 'APPS_LEVEL_3'
order by t.privilege desc;

select al.table_name,al.owner,al.tablespace_name,t.grantee, r.granted_role,t.privilege from ((ALL_TABLES al
inner join dba_tab_privs t
on al.owner = t.owner)
inner join dba_role_privs r
on t.GRANTEE = r.GRANTEE)
where t.grantee = 'A204505' and r.granted_role = 'APPS_LEVEL_3'
order by t.privilege desc;

--=======================================
---CHECK ACTIVE SESSION FOR PDB DATABASES
--=======================================
select
s.type,
p.name,
p.inst_id,
s.status,
s.server,
s.module, --s.type,p.name,p.inst_id,s.status,s.server,s.machine,s.module
s.machine,
count(*) cnt
from
gv$session s inner join gv$pdbs p on p.con_id = s.con_id and p.inst_id = s.inst_id
group by s.type,p.name,p.inst_id,s.status,s.server,s.module,s.machine
order by 1,2,3;


============================
FIND LONG RUNNING SESSIONS
============================
select SID, OPNAME,TARGET,TARGET_DESC,TOTALWORK,UNITS,START_TIME,
LAST_UPDATE_TIME,TIMESTAMP,MESSAGE,USERNAME,SQL_ADDRESS from v$session_longops;


===================
SEGMENT CHECKS
=======================
select a.owner, a.segment_name as TBL_INDEX, a.GB, b.table_name
from (
   select
      owner,
      segment_name,
      bytes/1024/1024/1024 GB
   from
      dba_segments
   where
      segment_type IN ('INDEX') -- ('TABLE', 'INDEX')
   order by
      bytes/1024/1024/1024 desc) a, dba_indexes b
where
    a.segment_name = b.index_name and
   rownum <= 1000 and a.OWNER in ('ODS_DBA','STG_HIST','STG_OPS','STG_SRC', 'STG_WORK','ODS_CLIREC_USR')
   ORDER BY a.gb desc;
   
select * from dba_indexes


select
   OWNER, SEGMENT_NAME AS TABLE_NAME, GB AS SIZE_IN_GB
from (
   select
      owner,
      segment_name,
      bytes/1024/1024/1024 GB
   from
      dba_segments
   where
      segment_type = 'TABLE'
   order by
      bytes/1024/1024/1024 desc)
where
   rownum <= 1000;
   
   
SELECT df.tablespace_name "Tablespace",
  totalusedspace "Used MB",
  (df.totalspace - tu.totalusedspace) "Free MB",
  df.totalspace "Total MB",
  ROUND(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace)) "% Free"
FROM
  (SELECT tablespace_name,
    ROUND(SUM(bytes) / 1048576) TotalSpace
  FROM dba_data_files
  GROUP BY tablespace_name
  ) df,
  (SELECT ROUND(SUM(bytes)/(1024*1024)) totalusedspace,
    tablespace_name
  FROM dba_segments
  GROUP BY tablespace_name
  ) tu
WHERE df.tablespace_name = tu.tablespace_name;

====================
ORACLE ASM
====================
select GROUP_NUMBER,NAME,BLOCK_SIZE,STATE,TYPE,TOTAL_MB/1024 as TOTAL_GB,FREE_MB/1024 as FREE_GB from v$asm_diskgroup;

select GROUP_NUMBER,NAME,STATE,TYPE,round(TOTAL_MB/1024/1024) TOTAL_MB, round(FREE_MB/1024/1024)  FREE_MB from v$asm_diskgroup;
select GROUP_NUMBER,NAME,STATE,TYPE,TOTAL_MB/1024/1024 TOTAL_TB, FREE_MB/1024/1024 FREE_TB from v$asm_diskgroup;

select
   g.name "GROUP_NAME",
   g.group_number,
   d.header_status,
   sum(d.total_mb) "TOTAL_MB",
   sum(d.free_mb) "FREE_MB",
   sum(d.total_mb)-sum(d.free_mb) "USED_MB",
  round((sum(d.total_mb)-sum(d.free_mb)) / sum(d.total_mb) * 100) "PERCENT_USED"
from
   v$asm_disk d,
   v$asm_diskgroup g
where
   d.group_number = g.group_number (+)
and
   d.header_status = 'MEMBER'
group by
   g.name,
   g.group_number,
   d.header_status
order by
   g.name;
 
 
Here is another query using v$asm_diskgroup:

with t as (
   select
      t.group_name,
      t.group_number,
      t.header_status,
      t.total_mb,
      t.free_mb,t.used_mb,
      round(t.used_mb/t.total_mb,2)*100 percent_calc
   from
      v$asm_diskgroup t)

select
   t.group_name,
   t.group_number,
   t.header_status,
   t.total_mb,
   t.free_mb - n.decompte free_mb,
   t.used_mb + n.decompte used_mb,
   round((t.used_mb + n.decompte)/t.total_mb,2)*100 percent
from
   t,
  (select (level-1)*5000 decompte from dual connect by level <= 10) n
where
   t.group_name = 'FRA';
   
=============================
FRA CHECKS
=============================

show parameter db_recovery_file_dest;

The Current FRA size we can check with the help of view v$recovery_area_usage for each file usage.
select * from v$recovery_area_usage;

Check overall size and usages of FRA with the help of v$recovery_file_dest view.
select name,round(space_limit / 1024 / 1024) size_mb,round(space_used/1024/1024) used_mb,decode(nvl(space_used,0),0,0,round((space_used/space_limit) * 100)) pct_used
from v$recovery_file_dest order by name;

=============================================
EXPORT DBCA AND RUNINSTALLER DISPLAY
=============================================
export DISPLAY=10.234.17.93:0.0
export CV_ASSUME_DISTID=OEL7.8


export DISPLAY=10.234.178.82:0.0


./gridSetup.sh -applyRU /u01/app/19.0.0/34130714/


./runInstaller.sh -applyRU /u01/app/oracle/34130714/

./emcli login -username=sysman

./emcli sync

./emcli get_supported_platforms


./emcli get_agentimage -destination=/tmp/agentinstaller -platform="Linux x86-64"

=======================
ODA ENVIRONMENT DETAILS
=======================
https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/
https://pngoda7:7093/mgmt/index.html
SQwer_1234#

==============================
ORACLE AUTONOMOUS DB TRAINING
===============================
bit.ly/mdw_lab
bit.ly/mdw_freetrial


=============================================
ORACLE DATABASE QUERY TUNNING TASK
=============================================
set serveroutput on
DECLARE l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => 'sql_id_here',
scope =>  DBMS_SQLTUNE.scope_comprehensive,
time_limit => 500,
task_name => 'sql_id_convenient_task_name_here',
description => 'Tunning task for sql statement sql_id_here');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/
l_sql_tune_task_id: task_name


=============================
Below script will display execution history of an sql_id from AWR. It will join dba_hist_sqlstat and dba_hist_sqlsnapshot table to get the required information.
select a.instance_number inst_id, a.snap_id,a.plan_hash_value, to_char(begin_interval_time,'dd-mon-yy hh24:mi') btime, abs(extract(minute from (end_interval_time-begin_interval_time)) + extract(hour from (end_interval_time-begin_interval_time))*60 + extract(day from (end_interval_time-begin_interval_time))*24*60) minutes,executions_delta executions, round(ELAPSED_TIME_delta/1000000/greatest(executions_delta,1),4) "avg duration (sec)" from dba_hist_SQLSTAT a, dba_hist_snapshot bwhere sql_id='&sql_id' and a.snap_id=b.snap_idand a.instance_number=b.instance_numberorder by snap_id desc, a.instance_number;



=============================================
MONITOR DATA PUMP IMPORT AND EXPORT PROGRESS
=============================================
SELECT b.username, a.sid,b.SQL_ID, b.opname, b.target,
round(b.SOFAR*100/b.TOTALWORK,0) || '%' as "%COMPLETED", b.TIME_REMAINING,
b.start_time, b.LAST_UPDATE_TIME, b.MESSAGE
FROM v$session_longops b, v$session a
WHERE a.sid = b.sid
and b.username in ('TBAADMR','SYS')
and round(b.SOFAR*100/b.TOTALWORK,0)<100
ORDER BY 6 desc;



=================================================
CHECK TABLESPACE UTILIZATION OF SOME TABLESPACES
==================================================
SELECT d.status "Status",
d.tablespace_name "Tablespace Name",
TO_CHAR (NVL (a.bytes / 1024 / 1024 / 1024, 0), '99,999,990.90') "Size (GB)",
TO_CHAR (NVL (a.bytes - NVL (f.bytes, 0), 0) / 1024 / 1024 / 1024,'99999999.99') "Used (GB)",
TO_CHAR (NVL (f.bytes / 1024 / 1024 / 1024, 0), '99,999,990.90') "Free (GB)",
TO_CHAR (NVL ( (a.bytes - NVL (f.bytes, 0)) / a.bytes * 100, 0),'990.00') "PCT USED"
FROM sys.dba_tablespaces d,
(SELECT tablespace_name, SUM (bytes) bytes
FROM dba_data_files
GROUP BY tablespace_name) a,
(SELECT tablespace_name, SUM (bytes) bytes
FROM dba_free_space
GROUP BY tablespace_name) f
WHERE d.tablespace_name = a.tablespace_name(+)
AND d.tablespace_name = f.tablespace_name(+)
AND NOT(d.extent_management LIKE 'LOCAL' AND d.contents LIKE 'TEMPORARY')
AND d.tablespace_name in ( 'PART_TAB_HTD_Q1_TBLSPC','PART_TAB_HTD_Q2_TBLSPC','PART_TAB_HTD_Q3_TBLSPC','PART_TAB_HTD_Q4_TBLSPC','PART_IDX_HTD_TBLSPC','UNDOTBS1')
order by TO_CHAR (NVL ( (a.bytes - NVL (f.bytes, 0)) / a.bytes * 100, 0),'990.00') desc;


===========================================
SCHEDULE A JOB USING SYS TO KILL INACTIVE SESSIONS
============================================
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'SYS.KILLCHACTMGRSESSION');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'SYS.KILLCHACTMGRSESSION'
      ,start_date      => TO_TIMESTAMP_TZ('2023/05/01 00:30:25.952716 +01:00','yyyy/mm/dd hh24:mi:ss.ff tzh:tzm')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL= 5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin SYS.KillChactmgrsessions(); end;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'RESTART_ON_RECOVERY'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'RESTART_ON_FAILURE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.KILLCHACTMGRSESSION'
     ,attribute => 'STORE_OUTPUT'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'SYS.KILLCHACTMGRSESSION');
END;
/

--THE PROCEDURE THAT THE ABOVE SCHEDULED JOB WILL BE USING
CREATE OR REPLACE procedure SYS.KillChactmgrsessions
as
BEGIN
  FOR r IN (select distinct b.serial#, b.sid, b.INST_ID
from
gv$locked_object a ,
gv$session b,
dba_objects c,
gV$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr
and c.owner ='TBAADM'
and b.username is not null
and b.username not in ('SYS','SYSTEM','FIEJB')
and b.program like '%chactmgr%'
and ((sysdate - d.start_date)  * 24 * 60) > 15
and ((sysdate - b.PREV_EXEC_START)  * 24 * 60) > 15
and b.status = 'INACTIVE')
--and b.client_info not like '%NGFIVUSR%')
  LOOP
      EXECUTE IMMEDIATE 'alter system kill session ''' || r.sid  || ','
        || r.serial# || ',@' || r.INST_ID || ''' immediate';
  END LOOP;
END;
/

