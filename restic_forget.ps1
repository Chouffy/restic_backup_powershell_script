<#
.Synopsis
   Call restic forget for the main script
.DESCRIPTION
   This script will call restic forget with defined parameters, send ping to HealthChecks, and log to $ResticLogForget
#>

Write-Output ("`n`n=== STARTING FORGET ===`n") | Tee-Object -FilePath $ResticLogForget -Append
Write-Output "Send start signal to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksForgetLink+"/start") -Method Post

& $ResticExecutable forget --option rclone.program="'"$RcloneExecutable"'" --keep-last=$ResticForgetKeepLast --keep-daily=$ResticForgetKeepDaily --keep-weekly=$ResticForgetKeepWeekly --keep-monthly=$ResticForgetKeepMonthly --keep-yearly=$ResticForgetKeepYearly $ResticDryRun *>&1 | Tee-Object -FilePath $ResticLogForget -Append

# If failed, send signal, otherwise send success ; then send log
if(-not $?) { Write-Output "`nSend fail signal to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksForgetLink+"/fail") -Method Post } else {Write-Output "`nSend success signal to HealthChecks ..."; Invoke-RestMethod -Uri $HealthChecksForgetLink -Method Post}
Write-Output "Send log to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksForgetLink+"/log") -Method Post -Body (Get-Content $ResticLogForget -Raw)
