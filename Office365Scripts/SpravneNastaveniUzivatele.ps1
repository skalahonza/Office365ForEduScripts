$cred = Get-Credential -UserName admin@GymnaziumDrEmila.onmicrosoft.com -
Connect-MsolService -Credential $cred
Get-MsolUser -Synchronized -DomainName "gyholi.cz"