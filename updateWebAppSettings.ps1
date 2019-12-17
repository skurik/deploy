param (
    [string] $resourceGroup,
    [string] $appName,
    [string] $connectionStringName,
    [string] $databaseName
)

$connstr = "Server=tcp:standaplayground.database.windows.net,1433;Initial Catalog=dynamicsqldb2;Persist Security Info=False;User ID=standaroot;Password=mypwd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

Set-AzWebApp -ResourceGroupName $resourceGroup -Name $appName -ConnectionStrings @{ $connectionStringName = @{ Type = "SQLAzure"; Value = $connstr }