# Set a value to pass into script block
$test = 'test'
1..10 | Start-RSJob -Throttle 5 -ScriptBlock {
    # Pull in var from outside the scriptblock
    [pscustomobject]@{
        Test=$Using:test
    }
    $seconds = Get-Random (1..5)
    Start-Sleep -Seconds $seconds
    Write-Output "Job $Using:test-$_ slept for $seconds seconds."
# Waits for all jobs to complete before outputting results with jobs in numerical order
#} | Wait-RSJob | Get-RSJob | Receive-RSJob

# Outputs each job's info as it completes
} | Wait-RSJob -Timeout 8 -ShowProgress | Receive-RSJob

Get-RSJob

Get-RSJob | Remove-RSJob -Verbose