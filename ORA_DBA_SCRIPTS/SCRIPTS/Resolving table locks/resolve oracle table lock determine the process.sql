---

SELECT vs.username,
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

 
 determine server process ID.
 
 
SELECT spid 
FROM v$process
WHERE addr IN 
(SELECT paddr FROM v$session WHERE sid=1102 AND serial#=55148); 
 
 
select sysdate - (1/12) from dual;


--- EOD Generated

select
*
from
v$locked_object a ,
v$session b,
dba_objects c,
V$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr 

and (module like '%babx4048@pngfin2 (TNS V1-V3)%' or MODULE LIKE '%babx4048@pngfin1 (TNS V1-V3)%')


and (module like '%icbx4008@pngfin1 (TNS V1-V3)%' or MODULE LIKE '%icbx4008@pngfin2 (TNS V1-V3)')
and (PROGRAM like '%icbx4008@pngfin1 (TNS V1-V3)%' or PROGRAM LIKE '%icbx4008@pngfin2 (TNS V1-V3)')


select event,count(*) from gv$session group by event;

select blocking_session from gv$session where event like '%TX%';

event#=246,  
---user generated.
a.inst_id,b.sid, b.serial#,b.sql_exec_start,d.start_time,d.status


select
*
from
gv$locked_object a ,
gv$session b,
dba_objects c,
gV$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr 
and (module like '%lisrvr-fin-listval@pngfin1 (TNS V1-V3)%' or MODULE LIKE'%lisrvr-fin-listval@pngfin2 (TNS V1-V3)%')
AND (PROGRAM like '%lisrvr-fin-listval@pngfin1 (TNS V1-V3)%' or PROGRAM LIKE'%lisrvr-fin-listval@pngfin2 (TNS V1-V3)%') 

and CLIENT_INFO LIKE '%CT000398%'


select sid,serial#,inst_id,status from gv$session where  CLIENT_INFO LIKE '%CT000398%' and event like '%cursor%'

SELECT spid 
FROM gv$process
WHERE addr IN 
(SELECT paddr FROM gv$session WHERE sid=449 AND serial#=5514); 



and CLIENT_INFO LIKE '%&sap_id%'



--and CLIENT_INFO LIKE '%A184759%'


--- resolution 

alter system kill session '975,35323,@1' immediate;


---- at OS level

SELECT spid 
FROM gv$process
WHERE addr IN 
(SELECT paddr FROM gv$session WHERE sid=975 AND serial#=35323); 









select
*
from
v$locked_object a ,
v$session b,
dba_objects c,
V$transaction d
where b.sid = a.session_id
and a.object_id = c.object_id
and d.ses_addr = b.saddr
and d.UBASQN != 0



select * from v$transaction



select * from v$transaction
WHERE XIDSQN=306047



select used_ublk from v$transaction
WHERE XIDSQN=306047



----alter system disconnect session ‘SID,SERIAL#’ immediate;
