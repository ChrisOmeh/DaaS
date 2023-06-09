select sid, s.username, status, machine, state, event, seconds_in_wait, sql_id
from v$session s, v$process p
where p.spid = &spid
and s.paddr = p.addr
/
