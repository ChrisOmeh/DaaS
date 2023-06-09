insert into alertuser.ahst_archival (select * from alertuser.ahst where r_Cre_time < to_timestamp(sysdate-1))
/
commit
/
delete from alertuser.ahst where r_Cre_time < to_timestamp(sysdate-1)
/
commit
/