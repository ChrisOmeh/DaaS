select sid, serial#
from v$session
where sid = (select sid
from v$mystat
where rownum < 2)
/
