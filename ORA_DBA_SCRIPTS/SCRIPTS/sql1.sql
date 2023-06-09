col csql head "Current SQL" format a50
col psql head "Previous SQL" format a50
select c.sql_text csql, p.sql_text psql
from v$sql p, v$sql c, v$session s
where s.sid = &sid
and p.sql_id (+) = s.sql_id
and c.sql_id (+) = s.prev_sql_id
/
