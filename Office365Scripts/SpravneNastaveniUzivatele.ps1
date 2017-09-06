$cred = Get-Credential
Connect-MsolService -Credential $cred
Get-MsolUser -Synchronized -DomainName "gyholi.cz"
