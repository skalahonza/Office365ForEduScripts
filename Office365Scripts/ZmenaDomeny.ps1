#
# ZmenaDomeny.ps1
# Skript změní přihlašovací jméno všech uživatelů s deafultní doméneou na novou doménu
#
Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

$domena = "@gyholi.cz" #na tuto doménu se budou měnit účty

# Najde všechny uživatel, kterým končí userprincipal name onmicrosoft.com
Get-MsolUser -All |
 Where { $_.UserPrincipalName.ToLower().EndsWith("onmicrosoft.com") } |
 ForEach {
 $upnVal = $_.UserPrincipalName.Split("@")[0] + $domena
 Write-Host "Menim uzivatelske jmeno: "$_.UserPrincipalName" na: " $upnVal -ForegroundColor Magenta
 Set-MsolUserPrincipalName -ObjectId $_.ObjectId -NewUserPrincipalName ($upnVal)
 }

 
Get-MsolUser -All | Select-Object UserPrincipalName, Title, DisplayName, IsLicensed

