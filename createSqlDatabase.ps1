param (
	[string] $location,
    [string] $resourceGroup,
    [string] $serverName,
    [string] $serverUserName,
    [string] $serverUserPassword,    
    [string] $edition,
    [string] $databaseName
)

# Creating a new SQL server is very slow

try
{
	Remove-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName -Force	
}
catch
{
  	Write-Host "Could not remove the existing SQL database"
  	Write-Host $_
}

#try
#{
#	Remove-AzSqlServer -ResourceGroupName $resourceGroup -ServerName $serverName -Force
#}
#catch
#{
#  	Write-Host "Could not remove the existing SQL server"
#  	Write-Host $_
#}

# $securePassword = ConvertTo-SecureString -String $serverUserPassword -AsPlainText -Force
# $serverCredentials = New-Object System.Management.Automation.PSCredential ($serverUserName, $securePassword)

# Write-Host "Creating a new SQL server ($serverName)"
# New-AzSqlServer -ResourceGroupName $resourceGroup -Location $location -ServerName $serverName -ServerVersion "12.0" -SqlAdministratorCredentials $serverCredentials

Write-Host "Creating a new SQL database ($databaseName) on $serverName"
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -Edition $edition -DatabaseName $databaseName