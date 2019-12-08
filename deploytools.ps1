function Retry([Action] $action, [int] $attempts, [int] $sleepInSeconds)
{    
    do
    {
        try
        {
            $action.Invoke();
            break;
        }
        catch [Exception]
        {
            Write-Host $_.Exception.Message
        }
        $attempts--
        if ($attempts -gt 0) { sleep $sleepInSeconds }
    } while ($attempts -gt 0)
}

function MyFunction($inputArg)
{
    Throw $inputArg
}

function DoIt($inp, $inp2)
{
    Retry({MyFunction "$inp $inp2"}) 3 5
}