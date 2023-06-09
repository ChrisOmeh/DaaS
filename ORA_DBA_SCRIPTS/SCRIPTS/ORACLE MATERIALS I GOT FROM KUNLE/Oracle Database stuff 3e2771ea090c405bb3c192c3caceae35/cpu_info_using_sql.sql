------------------------------------------------------- cpu per session
select * from
(
select username,sid,
       round((cpu_usage/(
                        select sum(value) total_cpu_usage
                          from gv$sesstat t
                         inner join gv$session  s on ( t.sid = s.sid )
                         inner join gv$statname n on ( t.statistic# = n.statistic# )
                         where n.name like '%CPU used by this session%'
                           and nvl(s.sql_exec_start, s.prev_exec_start) >= sysdate-1/24
                        ))*100,2) cpu_usage_per_cent,
       module_info,client_info 
  from
(
select nvl(s.username,'Oracle Internal Proc.') username,s.sid,t.value cpu_usage, nvl(s.module, s.program) module_info, decode(s.osuser,'oracle', s.client_info, s.osuser) client_info
  from gv$sesstat t
       inner join gv$session  s on ( t.sid = s.sid )
       inner join gv$statname n on ( t.statistic# = n.statistic# )
 where n.name like '%CPU used by this session%'
   and nvl(s.sql_exec_start, s.prev_exec_start) >= sysdate-1/24
) s1
)
order by cpu_usage_per_cent desc;


---------------------------------------------- 
select sum(value) total_cpu_usage
                          from gv$sesstat t
                         inner join gv$session  s on ( t.sid = s.sid )
                         inner join gv$statname n on ( t.statistic# = n.statistic# )
                         where n.name like '%CPU used by this session%'
                           and nvl(s.sql_exec_start, s.prev_exec_start) >= sysdate-1/24
                           
                           
select * from v$osstat

select * from v$osstat

select * from v$statname where name like '%CPU%'

select * from V$SYSSTAT where name = 'CPU used by this session'

select * from v$RSRC_CONSUMER_GROUP 
