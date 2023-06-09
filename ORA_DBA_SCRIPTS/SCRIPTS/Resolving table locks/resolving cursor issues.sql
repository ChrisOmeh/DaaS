select sql_id, sql_text, count(*) 
from gv$open_cursor
group by sql_id, sql_text
order by count(*) desc;


select * from ( select ss.value, sn.name, ss.sid
 from gv$sesstat ss, gv$statname sn
 where ss.statistic# = sn.statistic#
 and sn.name like '%opened cursors current%'
 order by value desc) where rownum < 11 ;
 
 
 select * from gv$session
 where sid ='714'