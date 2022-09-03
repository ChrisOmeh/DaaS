
#QUESTION 1
Get-Service | Where-Object {$_.Status -eq "Stopped"}

#QUESTION 2
Get-Service   "A", "X", "R", "W"

 #QUESTION 3
 Get-Service | Where-Object {$_.StartType -eq "Automatic"} > service_automatic_start.json
 
#QUESTION 4
Get-Service | select -Property name, status > export_serviceName_question4.txt

#QUESTION 5
Get-Service | select -Property name, status > export_serviceName_question5.html

#FOR PROCESS

#QUESTION 1
Get-Process   "T*", "N*", "S*"

#QUESTION 2
Get-Process  | select -ProcessName PM(K) Where ProcessName = "svchost"AND PM(K) > 100