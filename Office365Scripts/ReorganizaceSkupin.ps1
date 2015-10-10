#
# ReorganizaceSkupin.ps1
#
# pøehodí èleny skupin do vyššího roèníku
# napø.: pøehodí všechny èleny z 1.C do 2.C

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

#Získání všech skupin tøíd
Write-Host "Skupiny tøíd"
Get-MsolGroup | Where { $_.DisplayName.EndsWith(".C") -or $_.DisplayName.EndsWith(".A")}

#smazání skupiny "Absolventi osmiletého"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi osmiletého studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#smazání skupiny "Absolventi ètyøletého"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi ètyøletého studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#Pøesunutí pomaturitních roèníkù do skupiny absolventi
$group = Get-MsolGroup | Where { $_.DisplayName -eq "8.C"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi osmiletého studia" -Description "Absolventi osmiletého studia"

$group = Get-MsolGroup | Where { $_.DisplayName -eq "4.A"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi ètyøletého studia" -Description "Absolventi ètyøletého studia"

#Zmìna skupin na vyšší roèníky (1.C --> 2.C)
for($cislo = 7; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".C"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".C" -Description $noveCislo".C"
	Write-Host "Pøejmenovávám skupinu " $cislo".C" " na " $noveCislo".C"
}
#Zmìna skupin na vyšší roèníky (1.A --> 2.A)
for($cislo = 3; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".A"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".A" -Description $noveCislo".A"
	Write-Host "Pøejmenovávám skupinu " $cislo".A" " na " $noveCislo".A"
}


# vytvoøení nových skupin 1.C a 1.A
New-MsolGroup -DisplayName "1.C" -Description "1.C"
New-MsolGroup -DisplayName "1.A" -Description "1.A"

# pøiøazení obrázku tøídám - s tím bude problém

