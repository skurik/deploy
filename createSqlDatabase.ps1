param (
    [string] $resourceGroup,
    [string] $serverName,
    [string] $edition,
    [string] $databaseName
)

Write-Host "Creating a new SQL database ($databaseName) on $serverName"
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -Edition $edition -DatabaseName $databaseName