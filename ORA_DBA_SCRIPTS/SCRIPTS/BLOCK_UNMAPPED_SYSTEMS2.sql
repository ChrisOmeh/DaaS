--drop trigger sys.block_unmapped_systems ;

CREATE OR REPLACE TRIGGER sys.block_unmapped_systems 

  AFTER LOGON ON DATABASE 
 
 BEGIN
 
     
  If ((sys.check_user_systems(sys_context('USERENV', 'OS_USER'))) <> 1)
 
   then
   raise_application_error(-20001,'Denied!  You are not allowed to logon from host '||sys_context('USERENV', 'HOST')|| ' with IP Address'||sys_context('USERENV', 'IP_ADDRESS') || ' using '|| sys_context('USERENV', 'OS_USER'));
   INSERT INTO sys.FAILED_LOGON_SYSTEMS_TBL VALUES (sys_context('USERENV', 'OS_USER'),sys_context('USERENV', 'SESSION_USER'),sys_context('USERENV', 'HOST'),sys_context('USERENV', 'IP_ADDRESS'),SYSDATE);
   
    COMMIT;
 
  END if;
 
 END block_unmapped_systems;