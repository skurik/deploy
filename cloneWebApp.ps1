param (
    [string] $location,
    [string] $appServicePlan,
    [string] $resourceGroup,
    [string] $sourceAppName,
    [string] $destinationAppName
 )

Write-Host "Fetching the source application info"
$srcapp = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $sourceAppName

Write-Host $srcapp

Write-Host "Resource group: $resourceGroup"
Write-Host "Destination app name: $destinationAppName"
Write-Host "Location: $location"
Write-Host "AppServicePlan: $appServicePlan"

Write-Host "Cloning the source application into $destinationAppName"
$destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan -SourceWebApp $srcapp