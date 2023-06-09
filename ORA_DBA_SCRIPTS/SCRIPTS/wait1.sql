set lines 120
col event format a30
select 
	state, 
	event, 
	sid, 
	seconds_in_wait "Waiting(s)", 
	10*wait_time "Waited(s)"
from v$session
where username = 'ARUP'
/
