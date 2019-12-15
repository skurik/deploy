function Retry([Action] $action, [int] $attempts, [int] $sleepInSeconds)
{
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