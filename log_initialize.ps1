<#
.Synopsis
   Initialize logs for the main script
.DESCRIPTION
   This script will create 3 empty logs in the ./log/ folder, and assign variables to them.

   This will create the following files:
    - 2023-01-01 123000 config_template.ps1 1-Backup.log
    - 2023-01-01 123000 config_template.ps1 2-Forget.log
    - 2023-01-01 123000 config_template.ps1 3-Check.log
#>

# Get the current date & time - and put in a variable so we have same on the 3 files
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd HHmmss"

$LogFolder = Join-Path $PSScriptRoot "log"

$ResticLogBackup = Join-Path $LogFolder ($CurrentDateTime + " " + $BackupConfigName + " 1-Backup.log"); Write-Output $null >> $ResticLogBackup
$ResticLogForget = Join-Path $LogFolder ($CurrentDateTime + " " + $BackupConfigName + " 2-Forget.log"); Write-Output $null >> $ResticLogForget
$ResticLogCheck = Join-Path $LogFolder ($CurrentDateTime + " " + $BackupConfigName + " 3-Check.log"); Write-Output $null >> $ResticLogCheck
