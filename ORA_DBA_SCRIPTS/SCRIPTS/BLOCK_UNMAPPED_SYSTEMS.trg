DROP TRIGGER SYS.BLOCK_UNAUTH_SYSTEMS;

CREATE OR REPLACE TRIGGER SYS.BLOCK_UNAUTH_SYSTEMS
AFTER LOGON ON DATABASE
DECLARE
OSUSER VARCHAR2(200);
SESSIONUSER VARCHAR2(200);
HOSTNAME VARCHAR2(300);
  BEGIN
        select sys_context ('USERENV', 'OS_USER') into OSUSER from dual   ;
        select sys_context ('USERENV', 'HOST') into HOSTNAME from dual ;
        SELECT sys_context('USERENV','SESSION_USER') INTO SESSIONUSER FROM DUAL  ;
   
  
    If SESSIONUSER in (SELECT USER_NAME FROM SYS.UNBLOCKED_SYSTEMS_TBL) 
            AND HOSTNAME NOT IN (SELECT SYSTEM_NAME FROM SYS.UNBLOCKED_SYSTEMS_TBL)
    and OSUSER NOT IN (SELECT OS_USER FROM SYS.UNBLOCKED_SYSTEMS_TBL)
        then
        raise_application_error(-20001,'Denied!  You are not allowed to logon from host '||HOSTNAME|| ' using '|| OSUSER);
        
    elsif 
          OSUSER <> SESSIONUSER AND SESSIONUSER NOT IN (SELECT USER_NAME FROM SYS.UNBLOCKED_SYSTEMS_TBL) 
            and HOSTNAME NOT IN (SELECT SYSTEM_NAME FROM SYS.UNBLOCKED_SYSTEMS_TBL)
        THEN 
            raise_application_error(-20001,'Denied!  You are not allowed to logon AS '||SESSIONUSER|| ' using '|| OSUSER || ' on ' ||HOSTNAME);
            
        elsIF
            
            HOSTNAME <> ( SELECT SYSTEM_NAME FROM SYS.STAFF_SYSTEMS_TBL WHERE OSUSER=STAFFID ) 
            AND HOSTNAME NOT IN (SELECT SYSTEM_NAME FROM SYS.UNBLOCKED_SYSTEMS_TBL) 
        
         THEN 
            raise_application_error(-20000,'Denied!  You can only log on as '||SESSIONUSER|| ' using the system registered to '|| OSUSER);

          
        END if;
        
    END;