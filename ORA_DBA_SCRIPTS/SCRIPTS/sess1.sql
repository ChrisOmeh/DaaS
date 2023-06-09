select machine, terminal, program, status, sql_id, sql_child_number, prev_sql_id
from v$session
where sid = &sid
/
