CREATE OR REPLACE FUNCTION sys.check_user_systems(OSUSER VARCHAR2)
  RETURN NUMBER IS
 
 SESSIONUSER SYS.UNBLOCKED_SYSTEMS_TBL.DB_USER%TYPE;      --  Declares the session user
 HOSTNAME   SYS.UNBLOCKED_SYSTEMS_TBL.DB_USER%TYPE;       -- Declare the Host Machine
 HOSTIP    SYS.UNBLOCKED_SYSTEMS_TBL.HOST_IP%TYPE;   -- Declare the IP Address of the Host Machine
 RESP_CODE SYS.UNBLOCKED_SYSTEMS_TBL.HOST_IP%TYPE;  -- Declare the Response Code
 
  BEGIN
    RESP_CODE:=0;
    select sys_context('USERENV', 'HOST'), sys_context('USERENV','SESSION_USER'),sys_context('USERENV','IP_ADDRESS') into HOSTNAME,SESSIONUSER,HOSTIP from dual ;
    SELECT STATUS INTO  RESP_CODE FROM SYS.UNBLOCKED_SYSTEMS_TBL 
    WHERE UPPER(OS_USER)= UPPER(OSUSER)
    AND UPPER(DB_USER)= UPPER(SESSIONUSER)
    AND UPPER(HOST_NAME)= UPPER(HOSTNAME)
    AND ((HOST_IP =  HOSTIP) OR ( (HOST_IP is null) AND  (UPPER(HOST_NAME)='UNGORA1')) OR ((HOST_IP is null) AND (UPPER(HOST_NAME)='UNGORA2')));
    
    EXCEPTION 
            WHEN TOO_MANY_ROWS THEN 
        BEGIN   
            INSERT INTO sys.FAILED_LOGON_SYSTEMS_TBL VALUES (sys_context('USERENV', 'OS_USER'),sys_context('USERENV', 'SESSION_USER'),sys_context('USERENV', 'HOST'),sys_context('USERENV', 'IP_ADDRESS'),SYSDATE);
            COMMIT;
            RESP_CODE:=0;
           END;
        
        WHEN NO_DATA_FOUND THEN
        
        BEGIN   
            INSERT INTO sys.FAILED_LOGON_SYSTEMS_TBL VALUES (sys_context('USERENV', 'OS_USER'),sys_context('USERENV', 'SESSION_USER'),sys_context('USERENV', 'HOST'),sys_context('USERENV', 'IP_ADDRESS'),SYSDATE);
            COMMIT;
            RESP_CODE:=0;
         END;
         
        WHEN OTHERS THEN
        BEGIN   
            INSERT INTO sys.FAILED_LOGON_SYSTEMS_TBL VALUES (sys_context('USERENV', 'OS_USER'),sys_context('USERENV', 'SESSION_USER'),sys_context('USERENV', 'HOST'),sys_context('USERENV', 'IP_ADDRESS'),SYSDATE);
            COMMIT;
          RESP_CODE:=0;
        END;

     RETURN (RESP_CODE);
    
    END check_user_systems; 
    
       

 