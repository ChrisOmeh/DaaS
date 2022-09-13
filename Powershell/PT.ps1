Function Get-ServersInfo{
Param(
[Parameter(Mandatory=$true,Position=1)] [Int]$port,
[Parameter(Mandatory=$true,Position=0)] [String[]]$ComputerName
)
Write-Output "Computers :"
$ComputerName
}
Get-ServersInfo Computer1,Computer2 8088

Function Test-Parameter{
param ($computer_name = "LENN")
Write-Host "The computer name is: $computer_name"
}

