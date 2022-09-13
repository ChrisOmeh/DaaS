#=====================================================
#POWERSHELL ASSIGNMENT SOLUTION
#CODE WRITTEN BY TEAM-K8S
#=====================================================

#QUESTION 1
Get-Service | Where-Object {$_.Status -eq "Stopped"} | ft


#QUESTION 2
Get-Service  "A*", "X*", "R*", "W*" | Sort-Object Name | Out-File -FilePath .\DaaSserviceStart_with_AXRW_Ouestion2.txt #I made the path to export file into dynamic using '.' or $PWD.


#QUESTION 3
Get-Service | select -Property Name, Status, StartType| Where-Object {$_.StartType -eq "Automatic"} | Out-File -FilePath $PWD\DaaS_service_automatic_start_question3.json
 

#QUESTION 4
Get-Service | select -Property Name, Status | Sort-Object Status | Out-File -FilePath $PWD\DaaS_export_serviceName_to_text_question4.txt


#QUESTION 5
Get-Service | select -Property Name, StartType, Status | ConvertTo-Html | Out-File -FilePath .\DaaSexport_serviceName_to_html_question52.html


#FOR PROCESS SECTION OF THE ASSIGNMENT

#QUESTION 1
Get-Process   "T*", "N*", "S*" | Sort-Object ProcessName | ft #Format-List


#QUESTION 2
Get-Process  | where {($_.ProcessName -eq "svchost") -and ($_.PM -gt 100000000)}


#QUESTION 3
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | ft


#QUESTION 4 : Export Question 3 to html
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | convert-Html | Out-File -FilePath $PWD\DaaS_Export_Process_Question3_to_HTML.html


#QUESTION 5 : Export Question 3 to csv
Get-Process | select -Property ProcessName, Id, Handles, PM, CPU | where {($_.PM -gt 100000000) -and ($_.CPU -gt 1000)} | ft | Out-File -FilePath $PWD\DaaS_Export_Process_Question3_to_CSV.csv


#PART 3 OF THE ASSIGNMENT(AUTOMATION)

#QUESTION 1

#User enter IP address varibale. It is worthy to note that the question didn't specifiy what the user should enter. So, the question seem incomplete
$host_ip = Read-Host "Pls Enter your Host Computer IP Address" 
if(Test-Connection -ComputerName $host_ip -Count 1 -Quiet)
{
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



#QUESTION 2

#Start transcript command to enable logging
Start-Transcript -Path .\Result_log.txt

#user input from text file
$IP_address_file = Get-Content -Path .\User_IPAddresses.txt 
ForEach ($IP_address in $IP_address_file)
{
if ((Test-Connection -ComputerName $IP_address -Count 1 -Quiet) -eq $true)
    {Write-Host "==Local Machine can Ping the IP Address Successfully=="
    Write-Host "--------------------------------------------------------"
    ping -a $IP_address
    Write-Output "--------------------------------------"
    Write-Output "LOCAL MACHINE PINGED ADDRESS SUCCESSFULLY"
}

else
{
    Write-Host "===Local Machine cannot ping IP address==="
}}
Stop-Transcript


#QUESTION 3

#Reverses User Input
$text = Read-Host "Enter what is to be reversed" 
Write-Host "The user input is: $text"

$text = $Text.ToCharArray() 
[Array]::Reverse($text) -join $text

Write-Host "The reversed user input is: $text"

