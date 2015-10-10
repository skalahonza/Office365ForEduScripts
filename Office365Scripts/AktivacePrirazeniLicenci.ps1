#
# AktivacePrirazeniLicenci.ps1
# Skript aktivuje novì synchronizované uživatele a pøidìlí jim studentskou licenci
#

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

Write-Host "Pøipojeno"
Write-Host "Pøiøazování umístìní"

Get-MsolUser -UnlicensedUsersOnly | Set-MsolUser -UsageLocation CZ

Write-Host "Pøiøazování licencí"

Get-MsolUser -UnlicensedUsersOnly |
Set-MsolUserLicense -AddLicenses GymnaziumDrEmila:STANDARDWOFFPACK_STUDENT