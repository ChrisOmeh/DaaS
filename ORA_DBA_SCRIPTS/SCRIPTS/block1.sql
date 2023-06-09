select blocking_session, blocking_instance
from v$session
where sid = &sid
/
