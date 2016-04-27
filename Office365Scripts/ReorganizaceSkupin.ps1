#
# ReorganizaceSkupin.ps1
#
# prehodi cleny skupin do vyssiho rocniku
# napr.: prehodi vsechny cleny z 1.C do 2.C

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

#Ziskani vsech skupin trid
Write-Host "Skupiny trid"
Get-MsolGroup | Where { $_.DisplayName.EndsWith(".C") -or $_.DisplayName.EndsWith(".A")}

#smazani skupiny "Absolventi osmileteho"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi osmileteho studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#smazani skupiny "Absolventi ctyrleteho"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi ctyrleteho studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#Presunuti pomaturitnich rocniku do skupiny absolventi
$group = Get-MsolGroup | Where { $_.DisplayName -eq "8.C"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi osmileteho studia" -Description "Absolventi osmileteho studia"

$group = Get-MsolGroup | Where { $_.DisplayName -eq "4.A"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi ctyrleteho studia" -Description "Absolventi ctyrleteho studia"

#Zmena skupin na vyssi rocniky (1.C --> 2.C)
for($cislo = 7; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".C"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".C" -Description $noveCislo".C"
	Write-Host "Prejmenovavam skupinu " $cislo".C" " na " $noveCislo".C"
}
#Zmena skupin na vyssi rocniky (1.A --> 2.A)
for($cislo = 3; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".A"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".A" -Description $noveCislo".A"
	Write-Host "Prejmenovavam skupinu " $cislo".A" " na " $noveCislo".A"
}


# vytvoreni novych skupin 1.C a 1.A
New-MsolGroup -DisplayName "1.C" -Description "1.C"
New-MsolGroup -DisplayName "1.A" -Description "1.A"

# prirazeni obrazku tridam - s tim bude problem

