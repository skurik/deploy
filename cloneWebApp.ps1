param (
    [string] $location,
    [string] $appServicePlan,
    [string] $resourceGroup,
    [string] $sourceAppName,
    [string] $destinationAppName
 )

Remove-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Force

# There is a bug in Azure - while the application settings are cloned, the "Deployment slot settings" flag is not.
# This breaks our swap procedure as the staging slot will not start up due to its WEBSITE_SITE_TYPE variable being "staging"
$srcapp = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $sourceAppName

Write-Host "Cloning the source application into $destinationAppName"
$destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan

$keySelector = [System.Func``2[Microsoft.Azure.Management.WebSites.Models.NameValuePair, string]] { $args[0].Name }
$valueSelector = [System.Func``2[Microsoft.Azure.Management.WebSites.Models.NameValuePair, string]] { $args[0].Value }
$appSettingsMap = [System.Linq.Enumerable]::ToDictionary($srcapp.SiteConfig.AppSettings, $keySelector, $valueSelector)
$appSettingsHashtable = New-Object System.Collections.Hashtable($appSettingsMap)
$connectionString = $srcapp.SiteConfig.ConnectionStrings[0]

Write-Host "Copying the source app settings and connection string to the destination app"
Set-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -AppSettings $appSettingsHashtable -ConnectionStrings @{ $connectionString.Name = @{ Type = "SQLAzure"; Value = $connectionString.ConnectionString } }