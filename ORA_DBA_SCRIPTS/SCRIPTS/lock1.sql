col obj_name head "Owner.Object:Partition" format a40
select
	object_type,
	owner||'.'||object_name||':'||nvl(subobject_name,'-') obj_name,
	dbms_rowid.rowid_create (
		1,
		row_wait_obj#,
		row_wait_file#,
		row_wait_block#,
		row_wait_row#
	) row_id
from v$session s, dba_objects o
where sid = &sid
and o.data_object_id = s.row_wait_obj#
/
