function Retry([Action] $action, [int] $attempts, [int] $sleepInSeconds)
{
    Write-Host "Will wait $sleepInSeconds seconds between $attempts attempts"
    $remainingAttempts = $attempts
    do
    {
        try
        {
            $action.Invoke();
            return;
        }
        catch [Exception]
        {
            Write-Host $_.Exception.Message
        }
        
        $remainingAttempts--        
        if ($remainingAttempts -gt 0)
        {
            Start-Sleep -s $sleepInSeconds
        }
    } while ($remainingAttempts -gt 0)

    throw "The action failed after $attempts attempts"
}

function SendWebRequest([string] $uri)
{
    Write-Host "=============================================================================="
    Write-Host "Sending a request to $uri"
    $result = Invoke-WebRequest -UseBasicParsing -URI $uri
    Write-Host $result
    Write-Host "=============================================================================="
}

function CloneWebApp([string] $location, [string] $appServicePlan, [string] $resourceGroup, [string] $sourceAppName, [string] $destinationAppName)
{
    Write-Host "Fetching the source application info"
    $srcapp = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $sourceAppName

    Write-Host "Cloning the source application into $destinationAppName"
    $destapp = New-AzWebApp -ResourceGroupName $resourceGroup -Name $destinationAppName -Location $location -AppServicePlan $appServicePlan -SourceWebApp $srcapp    
}

function CreateSqlDatabase([string] $resourceGroup, [string] $serverName, [string] $edition, [string] $databaseName)
{
    New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -Edition $edition -DatabaseName $databaseName
}