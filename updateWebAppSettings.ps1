param (
    [string] $resourceGroup,
    [string] $appName,
    [string] $connectionStringName,
    [string] $sqlServerName,
    [string] $databaseName,
    [string] $serverUserName,
    [string] $serverUserPassword
)

# develop:
# Data Source=tcp:mews-develop-sql-weu.database.windows.net,1433;Initial Catalog=mews-develop-db;User ID=Mews-D79D02B7-2C1D-403D-8648-ABD3629D30EB@mews-develop-sql-weu;Password=4E0366BD-CCA2-49D0-9B4C-677A0DA9029A

$connstr = "Data Source=tcp:$sqlServerName.database.windows.net,1433;Initial Catalog=$databaseName;User ID=$serverUserName@$sqlServerName;Password=$serverUserPassword"

Set-AzWebApp -ResourceGroupName $resourceGroup -Name $appName -ConnectionStrings @{ $connectionStringName = @{ Type = "SQLAzure"; Value = $connstr } }