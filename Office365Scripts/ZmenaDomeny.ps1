#
# ZmenaDomeny.ps1
# Skript meni prihlasovaci jméno vsech uzivatelu s deafultní domenou na novou domenu
#
Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

$domena = "@gyholi.cz" #na tuto domenu se budou menit ucty

# Najde vsechny uzivatele, kterym konci userprincipal name na onmicrosoft.com
Get-MsolUser -All |
 Where { $_.UserPrincipalName.ToLower().EndsWith("onmicrosoft.com") } |
 ForEach {
 $upnVal = $_.UserPrincipalName.Split("@")[0] + $domena
 Write-Host "Menim uzivatelske jmeno: "$_.UserPrincipalName" na: " $upnVal -ForegroundColor Magenta
 Set-MsolUserPrincipalName -ObjectId $_.ObjectId -NewUserPrincipalName ($upnVal)
 }

 
Get-MsolUser -All | Select-Object UserPrincipalName, Title, DisplayName, IsLicensed

