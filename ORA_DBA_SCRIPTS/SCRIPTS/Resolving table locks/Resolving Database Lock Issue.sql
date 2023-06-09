-------------------------find locks and kill

select a.sid||'|'|| a.serial#||'|'|| a.process
 from gv$session a, gv$locked_object b, dba_objects c
 where b.object_id = c.object_id
 and a.sid = b.session_id
 and OBJECT_NAME=upper('&TABLE_NAME');
 
 
 ---find the processs
 
select distinct a.process
 from gv$session a, gv$locked_object b, dba_objects c
 where b.object_id = c.object_id
 and a.sid = b.session_id
 and OBJECT_NAME=upper('&TABLE_NAME');
 
 
-------------find blocking locks on the database


select 
    (select username from gv$session where sid=a.sid) blocker,
    a.sid,
    ' is blocking ',
    (select username from gv$session where sid=b.sid) blockee,
    b.sid
 from 
    gv$lock a, 
    gv$lock b
 where 
    a.block = 1
 and 
    b.request > 0
 and 
    a.id1 = b.id1
 and 
    a.id2 = b.id2;
 
 
---- find blocking session and type of lock

select l1.inst_id,l1.sid, ' IS BLOCKING ', l2.sid,l1.type,l2.type,l1.lmode,l2.lmode,l2.inst_id
 from gv$lock l1, gv$lock l2
 where l1.block =1 and l2.request > 0
 and l1.id1=l2.id1
 and l1.id2=l2.id2; 
 
 
SELECT 'Instance '||s1.INST_ID||' '|| s1.username || '@' || s1.machine
    || ' ( SID=' || s1.sid || ','|| s1.serial#||s1.status||  '  )  is blocking '
    || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' ||s2.sql_id
     FROM gv$lock l1, gv$session s1, gv$lock l2, gv$session s2
    WHERE s1.sid=l1.sid AND
     s1.inst_id=l1.inst_id AND
     s2.sid=l2.sid AND
     s2.inst_id=l2.inst_id AND
     l1.BLOCK=1 AND
    l2.request > 0 AND
    l1.id1 = l2.id1 AND
    l2.id2 = l2.id2 ;
 
 
 
 
 
 
--------------------------------------------------------------------


--- 1. For Bankwide issues use query below  For Individual users use the second query
select event,count(*) Total from gv$session group by event order by Total desc

----------------------------------------
V$ROLLSTAT and V$UNDOSTAT

-----------------------------------------
select sid, state,event,state, wait_time, seconds_in_wait from gv$session
where event not in ( 'SQL*NET message from client','SQL*NET message to client','rdbms ipc message'
)and state='WAITING'



select event,seconds_in_wait,status from v$session where program like '%DW%' order by seconds_in_wait desc ;
-------------------------------------------------

SElect sid, s.username, status, machine, state, seconds_in_wait,sql_id
from v$session s, v$process p where  s.paddr = p.addr and p.spid=&spid  

---------------------------------------------------------
Check lock on table

select l.*, o.object_name from v$locked_object l, dba_objects o 
where l.object_id = o.object_id 
and o.object_type = 'TABLE' 
and o.owner = upper('TBAADM') 
and o.object_name in ('PAYMENT_ORDER_DETAIL_TABLE', 'PAYMENT_ORDER_HEADER_TABLE', 'GENERAL_ACCT_MAST_TABLE'); 

--------------------------------------------------
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
order by d.start_time asc


select * from gv$process where addr In (select creator_addr from gv$session where sid=256 and serial#=34446);

-----mutex check --------

Select a.inst_id,a.sid,a.SERIAL#,a.username,event, 'kill -9 '||b.spid command  from
 gv$session a, gv$process b 
 where a.paddr=b.addr
 and event like '%mutex%'
AND (A.INST_ID=1 or  A.INST_ID=2)
and A.INST_ID = b.INST_ID


------Happenings ------------------------

select
s.sid,
   substr(s.username,1,18) username,
   s.sql_exec_start,
   s.machine,
   substr(s.program,1,15) program,
   decode(s.command,
     0,'No Command',
     1,'Create Table',
     2,'Insert',
     3,'Select',
     6,'Update',
     7,'Delete',
     9,'Create Index',
     15,'Alter Table',
     21,'Create View',
     23,'Validate Index',
     35,'Alter Database',
     39,'Create Tablespace',
     41,'Drop Tablespace',
     40,'Alter Tablespace',
     53,'Drop User',
     62,'Analyze Table',
     63,'Analyze Index',
     s.command||': Other') command
from
   v$session     s,
   v$process     p,
   v$transaction t,
   v$rollstat    r,
   v$rollname    n
where s.paddr = p.addr
and s.taddr = t.addr (+)
and t.xidusn = r.usn (+)
and r.usn = n.usn (+)
and s.command <> 0
and s.username='CRMUSER'
--and s.machine='pngwas6'
order by 1;




----------------------------------------------------

Select a.inst_id,a.sid,a.SERIAL#,a.username,event, 'kill -9 '||b.spid command  from
 gv$session a, gv$process b ,gv$transaction d
 where a.paddr=b.addr
and a.program like '%lisrvr-mqswiftout%'
and a.status='INACTIVE'
and d.status='ACTIVE'
AND (A.INST_ID=1 or  A.INST_ID=2)
and A.INST_ID = b.INST_ID
and d.ses_addr = a.saddr 

-------

SELECT 'alter system kill session ''' || s.sid || ',' || s.SERIAL# || ''';' a,
'ps -ef |grep LOCAL=NO|grep ' || p.SPID SPID,
'kill -9 ' || p.SPID
FROM gv$session s, gv$process p
WHERE ( (p.addr(+) = s.paddr) AND (p.inst_id(+) = s.inst_id))
AND s.sid = &sid;




------Resolving Cursor Spin Event ------

select s.inst_id as inst,
       s.sid as blocked_sid, 
       s.username as blocked_user,
       sa.sql_id as blocked_sql_id,
       trunc(s.p2/4294967296) as blocking_sid,
       b.username as blocking_user,
       b.sql_id as blocking_sql_id
from gv$session s
join gv$sqlarea sa
  on sa.hash_value = s.p1
join gv$session b
  on trunc(s.p2/4294967296)=b.sid
 and s.inst_id=b.inst_id
join gv$sqlarea sa2
  on b.sql_id=sa2.sql_id
where s.event='cursor: pin S wait on X';

---------check if SGA tried to grow ----------------

SELECT component, oper_type, oper_mode, parameter, 
initial_size/1024/1024 init_MB, 
target_size/1024/1024 target_MB, 
final_size/1024/1024 final_MB,
status, start_time, end_time 
FROM V$SGA_RESIZE_OPS    ;

  ---- Resource Limit Check.

select * from gv$resource_limit
where limit_value not like '%UNLIMITED%'
ORDER BY LIMIT_VALUE ASC


select * from gv$resource_limit
where limit_value not like '%UNLIMITED%'
and resource_name like 'processes'
or resource_name like 'sessions'
or resource_name like 'parallel_max_servers'
ORDER BY LIMIT_VALUE ASC;



SELECT inst_id, sid , serial#, opname, (sofar/totalwork *100) "%_COMPLETE"  FROM gV$SESSION_LONGOPS ;
WHERE OPNAME LIKE 'RMAN%'
  AND OPNAME NOT LIKE '%aggregate%'
  AND TOTALWORK != 0
  --AND SOFAR <> TOTALWORK
  order by "%_COMPLETE" asc;
  
  
  select distinct(opname) FROM gV$SESSION_LONGOPS
WHERE OPNAME LIKE 'RMAN%'
  
--------------------Resolving Database Lock Issues on RedBox ----------------------------------

SELECT 'kill -9 '||b.spid command ,vs.username
FROM gv$lock vh,
 gv$lock vw,
 gv$session vs,
 gv$session vsw,
 dba_scheduler_running_jobs jrh,
 gv$process b ,
 dba_scheduler_running_jobs jrw
WHERE     (vh.id1, vh.id2) IN (SELECT id1, id2
 FROM gv$lock
 WHERE request = 0
 INTERSECT
 SELECT id1, id2
 FROM gv$lock
 WHERE lmode = 0)
 AND vh.id1 = vw.id1
 AND vh.id2 = vw.id2
 AND vh.request = 0
 AND vw.lmode = 0
 AND vh.sid = vs.sid
 AND vw.sid = vsw.sid
 AND vh.sid = jrh.session_id(+)
 AND vw.sid = jrw.session_id(+)
 and vsw.event like '%TX%'
 and b.addr = vs.paddr
 and VS.status='INACTIVE'  

  
  
------------------ Important Performance Views------------------------------
v$sesstat
v$statname
v$sysstat
v$session_event join on event# with v$event_name  ( similar view is v$system_event. This host data for the entire system)
v$session_wait_history

v$active_session_history



select name , value from v$sesstat s, v$statname n
where s.statistic# = n.statistic#
and upper (name) like '%CPU%'
and sid= (SID);



-----------------------------------


select count (*) from tbaadm.dtd where tran_date = '02-APR-2014' and del_flg != 'Y'  
AND GST_UPD_FLG !='Y' and EABFAB_UPD_FLG != 'Y'


select count(*) from tbaadm.htd where tran_date = '02-APR-2014' and del_flg != 'Y'  -- where date is current transaction date.

select count (*) from tbaadm.dth where tran_date = '02-APR-2014' and del_flg != 'Y' 


----- Use the query below for specific user issue with cannot get response from server.

select
a.inst_id,b.sid, b.serial#,b.sql_exec_start,d.start_time,c.owner,c.object_name,b.program,b.client_info,d.status
from
gv$locked_object a ,
gv$session b,
dba_objects c,
gV$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr 
and CLIENT_INFO LIKE '%CT000342%'
order by d.start_time asc

--------------------------Investigating Locks on Redbox ------------------------------------

SELECT 'kill -9 '||b.spid command ,vs.username,
vs.BLOCKING_INSTANCE,
vsw.event,
 vs.osuser,
 vh.sid locking_sid,
 vs.status status,
 vs.module module,
 vs.program program_holding,
 jrh.job_name,
 vsw.username,
 vsw.osuser,
 vw.sid waiter_sid,
 vsw.program program_waiting,
 jrw.job_name,
 'alter system kill session ' || ''''|| vh.sid || ',' || vs.serial# || ''';'  "Kill_Command"
FROM gv$lock vh,
 gv$lock vw,
 gv$session vs,
 gv$session vsw,
 dba_scheduler_running_jobs jrh,
 gv$process b ,
 dba_scheduler_running_jobs jrw
WHERE     (vh.id1, vh.id2) IN (SELECT id1, id2
 FROM gv$lock
 WHERE request = 0
 INTERSECT
 SELECT id1, id2
 FROM gv$lock
 WHERE lmode = 0)
 AND vh.id1 = vw.id1
 AND vh.id2 = vw.id2
 AND vh.request = 0
 AND vw.lmode = 0
 AND vh.sid = vs.sid
 AND vw.sid = vsw.sid
 AND vh.sid = jrh.session_id(+)
 AND vw.sid = jrw.session_id(+)
 and vsw.event like '%TX%'
 and b.addr = vs.paddr
 and VS.status='INACTIVE'

--------------------------

select * from tbaadm.lgt where user_id='CT000342' order by login_log_time desc;

---- Kill the process on the database using the SID and the Serial#  and the database instance_id


alter system kill session 'sid,serial#' immediate;


alter system kill session '869,3461,@1' immediate;

---- Kill the process on the OS of the database using the SPID and the noting the particular database instance 

select owner, object_name, object_type, created, last_ddl_time, status
  from all_objects 
 where created >= (sysdate -90)
 and owner in ('ALERTUSER','CUSTOM','SVSUSER','TBAADM', 'CRMUSER','INTADM','TBAGEN','SSOADM')
 AND OBJECT_TYPE = 'TABLE'
 
 
 ---GRANT SELECT Privilege on each Table
 
 spool grant_select.sql
select 'GRANT SELECT ON '||table_name||' TO <read_only_user>;' from user_tables;
spool off


----RESOLVE SCHEDULER Issues

SELECT * from scheduler$_job where PROGRAM_ACTION like '%CRMUSER%' 

update scheduler$_job set job_status=1 where OBJ#=2971889