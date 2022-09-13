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

