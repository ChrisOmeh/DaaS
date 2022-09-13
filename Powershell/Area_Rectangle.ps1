[int]$length = Read-Host "What is length of the rectangle?"
[int]$width = Read-Host "What is width of the rectangle?"
$area_rect = $length * $width

if ($length -gt $width)
{
Write-Host "It is a Rectangle since the length is greater than width and the area is: $area_rect sq m"
}
else
{
Write-Host "The shape is not a Rectangle"
}
#Get-Host