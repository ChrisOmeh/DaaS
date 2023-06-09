declare
	l_dummy varchar2(200);
begin
	select max(test1.owner)
	into l_dummy
	from test1, test2, test2, test2, test2,
		test2, test2, test2, test2,
		test2, test2, test2, test2,
		test2, test2, test2, test2,
		test2, test2, test2, test2,
		test2, test2, test2, test2;
	dbms_lock.sleep(120);
end;
/
