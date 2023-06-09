declare
    l_dummy_1   varchar2(2000);
    l_dummy_2   varchar2(2000);
    l_stmt      varchar2(2000);
begin
    for i in 1..71540 loop
        l_stmt :=
            'select to_char(col2,''mm/dd/yyyy hh24:mi:ss'')'||
            ' from test3'||
            ' where col1 = to_char('||i||')';
        dbms_output.put_line('l_stmt='||l_stmt);
        execute immediate l_stmt into l_dummy_1;
        l_stmt :=
            'select col1 '||
            'from test3 '||
            'where col2 = to_date('''||
            l_dummy_1||
            ''',''mm/dd/yyyy hh24:mi:ss'')'||
            ' and col1 = '''||to_char(i)||'''';
        dbms_output.put_line('l_stmt='||l_stmt);
        execute immediate l_stmt into l_dummy_2;
    end loop;
end;
/
