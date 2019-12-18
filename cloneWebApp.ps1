param (
    [string] $location,
    [string] $appServicePlan,
    [string] $resourceGroup,
    [string] $sourceAppName,
    [string] $destinationAppName
 )

Remove-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Force

Write-Host "Fetching the source application info"
$srcapp = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $sourceAppName

Write-Host "Cloning the source application into $destinationAppName"
$destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan -SourceWebApp $srcapp -IncludeSourceWebAppSlots