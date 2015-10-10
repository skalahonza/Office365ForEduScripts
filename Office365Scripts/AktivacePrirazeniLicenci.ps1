#
# AktivacePrirazeniLicenci.ps1
# Skript aktivuje nov� synchronizovan� u�ivatele a p�id�l� jim studentskou licenci
#

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

Write-Host "P�ipojeno"
Write-Host "P�i�azov�n� um�st�n�"

Get-MsolUser -UnlicensedUsersOnly | Set-MsolUser -UsageLocation CZ

Write-Host "P�i�azov�n� licenc�"

Get-MsolUser -UnlicensedUsersOnly |
Set-MsolUserLicense -AddLicenses GymnaziumDrEmila:STANDARDWOFFPACK_STUDENT