select name, value
from v$sesstat s, v$statname n
where sid = &sid
and n.statistic# = s.statistic#
and value > 0
order by 2
/
