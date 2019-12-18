param (
	[string] $location,
    [string] $resourceGroup,
    [string] $serverName,
    [string] $serverUserName,
    [string] $serverUserPassword,    
    [string] $edition,
    [string] $databaseName
)


$securePassword = ConvertTo-SecureString -String $serverUserPassword -AsPlainText -Force
$serverCredentials = New-Object System.Management.Automation.PSCredential ($serverUserName, $securePassword)

Write-Host "Creating a new SQL server ($serverName)"
New-AzSqlServer -ResourceGroupName $resourceGroup -Location $location -ServerName $serverName -ServerVersion "12.0" -SqlAdministratorCredentials $serverCredentials

Write-Host "Creating a new SQL database ($databaseName) on $serverName"
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -Edition $edition -DatabaseName $databaseName