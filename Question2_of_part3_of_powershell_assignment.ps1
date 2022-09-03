#Start transcript command to enable logging
Start-Transcript -Path .\Result_log.txt

#user input from ext file
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

