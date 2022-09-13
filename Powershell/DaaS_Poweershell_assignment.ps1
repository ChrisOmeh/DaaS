
#QUESTION 1
Get-Service | Where-Object {$_.Status -eq "Stopped"}


#QUESTION 2
Get-Service  "A*", "X*", "R*", "W*" | Sort-Object Name | Out-File -FilePath $PWD\DaaSserviceStart_with_AXRW_Ouestion2.txt #I made the path to export file into dynamic.


#QUESTION 3
Get-Service | select -Property Name, Status, StartType| Where-Object {$_.StartType -eq "Automatic"} | Out-File -FilePath $PWD\DaaS_service_automatic_start_question3.json
 

#QUESTION 4
Get-Service | select -Property Name, Status | Sort-Object Status | Out-File -FilePath $PWD\DaaS_export_serviceName_to_text_question4.txt


#QUESTION 5
Get-Service | select -Property Name, StartType, Status | Out-File -FilePath $PWD\DaaSexport_serviceName_to_html_question5.html


#FOR PROCESS

#QUESTION 1
Get-Process   "T*", "N*", "S*" | Sort-Object ProcessName


#QUESTION 2
Get-Process  | where {($_.ProcessName -eq "svchost") -and ($_.PM -gt 100000000)}


#QUESTION 3
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | ft


#QUESTION 4 : Export Question 3 to html
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | ft | Out-File -FilePath $PWD\DaaS_Export_Process_Question3_to_HTML.html


#QUESTION 5 : Export Question 3 to csv
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | ft | Out-File -FilePath $PWD\DaaS_Export_Process_Question3_to_CSV.csv


#PART 3 OF THE ASSIGNMENT
$host_ip = Read-Host "Pls Enter your Host Computer IP Address" 
if(Test-Connection -ComputerName $host_ip -Count 1 -Quiet){
Write-Output "====TESTING CONNECTION TO SERVER====="
Write-Output "--------------------------------------"
Write-Output "===SERVER CONNECTIVITY WAS SUCCESSFUL==="
Write-Output "--------------------------------------"
Write-Output "====PINGING HOST ADDRESS====="
ping -a $host_ip
Write-Output "--------------------------------------"
Write-Output "HOST ADDRESS SUCCESSFULLY PINGED"
}
else{
Write-Output "===================================="
Write-Output "===SERVER CONNECTIVITY FAILED==="
}