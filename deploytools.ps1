function Retry([Action] $action, [int] $attempts, [int] $sleepInSeconds)
{
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
        $attempts--
        if ($attempts -gt 0) { sleep $sleepInSeconds }
    } while ($attempts -gt 0)

    throw "The action failed after $attempts attempts"
}

function SendWebRequest([string] $uri)
{
    $result = Invoke-WebRequest -UseBasicParsing -URI $uri
    Write-Host $result
}