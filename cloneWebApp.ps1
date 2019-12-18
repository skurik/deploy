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
#
# Write-Host "Fetching the source application info"
# $srcapp = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $sourceAppName

Write-Host "Cloning the source application into $destinationAppName"
$destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan
# $destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan -SourceWebApp $srcapp -IncludeSourceWebAppSlots