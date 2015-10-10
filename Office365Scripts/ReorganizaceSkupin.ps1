#
# ReorganizaceSkupin.ps1
#
# p�ehod� �leny skupin do vy���ho ro�n�ku
# nap�.: p�ehod� v�echny �leny z 1.C do 2.C

Import-Module Azure
Import-Module MSOnline

$cred = Get-Credential
Connect-MsolService -Credential $cred

#Z�sk�n� v�ech skupin t��d
Write-Host "Skupiny t��d"
Get-MsolGroup | Where { $_.DisplayName.EndsWith(".C") -or $_.DisplayName.EndsWith(".A")}

#smaz�n� skupiny "Absolventi osmilet�ho"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi osmilet�ho studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#smaz�n� skupiny "Absolventi �ty�let�ho"
$group = Get-MsolGroup | Where { $_.DisplayName -eq "Absolventi �ty�let�ho studia"} 
Remove-MsolGroup -ObjectId $group.ObjectId -Force

#P�esunut� pomaturitn�ch ro�n�k� do skupiny absolventi
$group = Get-MsolGroup | Where { $_.DisplayName -eq "8.C"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi osmilet�ho studia" -Description "Absolventi osmilet�ho studia"

$group = Get-MsolGroup | Where { $_.DisplayName -eq "4.A"}
Set-MsolGroup -ObjectId $group.ObjectId -DisplayName "Absolventi �ty�let�ho studia" -Description "Absolventi �ty�let�ho studia"

#Zm�na skupin na vy��� ro�n�ky (1.C --> 2.C)
for($cislo = 7; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".C"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".C" -Description $noveCislo".C"
	Write-Host "P�ejmenov�v�m skupinu " $cislo".C" " na " $noveCislo".C"
}
#Zm�na skupin na vy��� ro�n�ky (1.A --> 2.A)
for($cislo = 3; $cislo -ge 1; $cislo --)
{
	$skupinaTridy = Get-MsolGroup -SearchString $cislo".A"
	$noveCislo = $cislo + 1
	Set-MsolGroup -ObjectId $skupinaTridy.ObjectId -DisplayName $noveCislo".A" -Description $noveCislo".A"
	Write-Host "P�ejmenov�v�m skupinu " $cislo".A" " na " $noveCislo".A"
}


# vytvo�en� nov�ch skupin 1.C a 1.A
New-MsolGroup -DisplayName "1.C" -Description "1.C"
New-MsolGroup -DisplayName "1.A" -Description "1.A"

# p�i�azen� obr�zku t��d�m - s t�m bude probl�m

