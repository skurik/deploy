param (
    [string] $resourceGroup,
    [string] $appName,
    [string] $connectionStringName,
    [string] $sourceDatabaseName,
    [string] $databaseName
)

# develop:
# Data Source=tcp:mews-develop-sql-weu.database.windows.net,1433;Initial Catalog=mews-develop-db;User ID=Mews-D79D02B7-2C1D-403D-8648-ABD3629D30EB@mews-develop-sql-weu;Password=4E0366BD-CCA2-49D0-9B4C-677A0DA9029A

Write-Host "Getting the app"
$app = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $appName
Write-Host $app
$connectionString = ($app.SiteConfig.ConnectionStrings | where { $_.Name -eq "mews-develop-sql-weu/mews-develop-db" })[0].ConnectionString
Write-Host $connectionString
$updatedConnectionString = $connectionString.Replace($sourceDatabaseName, $databaseName)
Write-Host $updatedConnectionString

# $connstr =  "Data Source=tcp:$sqlServerName.database.windows.net,1433;Initial Catalog=$databaseName;User ID=$serverUserName@$sqlServerName;Password=$serverUserPassword"

Set-AzWebApp -ResourceGroupName $resourceGroup -Name $appName -ConnectionStrings @{ $connectionStringName = @{ Type = "SQLAzure"; Value = $updatedConnectionString } }