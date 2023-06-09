create table test1 as select * from all_objects
/
create table test2 as select * from all_objects
/
create table t1 (col1 number, col2 varchar2(1))
/
insert into t1 values (1,'A')
/
commit;create table test3
as
select rownum col1, created col2
from test2
/
