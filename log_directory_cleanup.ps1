<#
.Synopsis
   Remove old files from $LogFolder
.DESCRIPTION
   Remove objects in the $LogFolder that are created more than 30 days ago.
   The result is sent to $ResticLogCheck as this script is meant to be called by the main script.
#>

Write-Output ("`n`n=== STARTING LOG CLEANUP ===`n") | Tee-Object -FilePath $ResticLogCheck -Append
Get-ChildItem -Path $LogFolder -include *.log -Recurse | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) } | Tee-Object -FilePath $ResticLogCheck -Append | Remove-Item 
Write-Output "Send log to HealthChecks ..."; Invoke-RestMethod -Uri ($HealthChecksCheckLink+"/log") -Method Post -Body (Get-Content $ResticLogCheck -Raw)