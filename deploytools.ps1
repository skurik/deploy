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
        if ($remainingAttempts -gt 0) { sleep $sleepInSeconds }
    } while ($remainingAttempts -gt 0)

    throw "The action failed after $attempts attempts"
}