SELECT TRAN_AMT,TRAN_PARTICULAR,TRAN_RMKS FROM TBAADM.DTD WHERE TRAN_ID='   S72876' AND TRAN_DATE='19-NOV-2013'
ORDER BY TRAN_AMT DESC



select * from TBAADM.dTd where TRAN_DATE ='10-NOV-2013' AND acid =(select acid from tbaadm.gam where foracid='9202314303')