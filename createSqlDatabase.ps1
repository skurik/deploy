param (
	[string] $location,
    [string] $resourceGroup,
    [string] $serverName,
    [string] $serverUserName,
    [string] $serverUserPassword,    
    [string] $edition,
    [string] $databaseName
)

try
{
	Remove-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName -Force
	Remove-AzSqlServer -ResourceGroupName $resourceGroup -ServerName $serverName -Force	
}
catch
{
  	Write-Host "Could not remove the existing SQL server or database"
  	Write-Host $_
}

$securePassword = ConvertTo-SecureString -String $serverUserPassword -AsPlainText -Force
$serverCredentials = New-Object System.Management.Automation.PSCredential ($serverUserName, $securePassword)

Write-Host "Creating a new SQL server ($serverName)"
New-AzSqlServer -ResourceGroupName $resourceGroup -Location $location -ServerName $serverName -ServerVersion "12.0" -SqlAdministratorCredentials $serverCredentials

Write-Host "Creating a new SQL database ($databaseName) on $serverName"
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -Edition $edition -DatabaseName $databaseName