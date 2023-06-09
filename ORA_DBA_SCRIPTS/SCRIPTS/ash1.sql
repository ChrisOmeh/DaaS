col SAMPLE_TIME format a25
select SAMPLE_TIME, SESSION_STATE, event, time_waited, wait_time, DELTA_TIME, DELTA_READ_IO_REQUESTS, DELTA_WRITE_IO_REQUESTS, DELTA_READ_IO_BYTES,
DELTA_WRITE_IO_BYTES 
from  v$active_session_history
where session_id = &sid
order by SAMPLE_ID
/
