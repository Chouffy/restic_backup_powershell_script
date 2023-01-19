<#
.Synopsis
   Call restic backup for the main script
.DESCRIPTION
   This script will call restic backup with defined parameters, send ping to HealthChecks, and log to $ResticLogBackup
#>

Write-Output ("`n`n=== STARTING BACKUP WITH TAG: " + $ResticBackupTag + " ===`n") | Tee-Object -FilePath $ResticLogBackup -Append
Write-Output "Send start signal to HealthChecks ..."; Invoke-RestMethod ($HealthChecksBackupLink+"/start")

& $ResticExecutable backup $ResticBackupFolder --option rclone.program="'"$RcloneExecutable"'" $ResticUseFSSnapshot --verbose --host=$env:COMPUTERNAME --tag=$ResticBackupTag --exclude-if-present=$ResticExcludeIfPresent $ResticDryRun *>&1 | Tee-Object -FilePath $ResticLogBackup -Append

# If failed, send signal, otherwise send success ; then send log
if(-not $?) { Write-Output "`nSend fail signal to HealthChecks ..."; Invoke-RestMethod ($HealthChecksBackupLink+"/fail")} else {Write-Output "`nSend success signal to HealthChecks ..."; Invoke-RestMethod $HealthChecksBackupLink}
Write-Output "Send log to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksBackupLink+"/log") -Method Post -Body (Get-Content $ResticLogBackup -Raw)
