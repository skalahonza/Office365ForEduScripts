#
# AktivacePrirazeniLicenci.ps1
# Skript aktivuje nove synchronizovane uzivatele a prideli jim studentskou licenci
#

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

Write-Host "Pripojeno"
Write-Host "Prirazovani umisteni"

Get-MsolUser -UnlicensedUsersOnly | Set-MsolUser -UsageLocation CZ

Write-Host "Prirazovani licenci uzivatelum"

Get-MsolUser -UnlicensedUsersOnly |
Set-MsolUserLicense -AddLicenses GymnaziumDrEmila:STANDARDWOFFPACK_STUDENT