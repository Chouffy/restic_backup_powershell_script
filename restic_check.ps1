<#
.Synopsis
   Call restic check for the main script
.DESCRIPTION
   This script will call restic check with defined parameters, send ping to HealthChecks, and log to $ResticLogCheck
#>

Write-Output ("`n`n=== STARTING CHECK ===`n") | Tee-Object -FilePath $ResticLogCheck -Append
Write-Output "Send start signal to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksCheckLink+"/start")  -Method Post

& $ResticExecutable check --option rclone.program="'"$RcloneExecutable"'" --read-data-subset=$ResticCheckReadDataSubset *>&1 | Tee-Object -FilePath $ResticLogCheck -Append

# If failed, send signal, otherwise send success ; then send log
if(-not $?) { Write-Output "`nSend fail signal to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksCheckLink+"/fail") -Method Post } else {Write-Output "`nSend success signal to HealthChecks ..."; Invoke-RestMethod -Uri $HealthChecksCheckLink -Method Post} 
