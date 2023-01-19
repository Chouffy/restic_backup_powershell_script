<#
.Synopsis
   Initialize a restic environment for the main script     
.DESCRIPTION
   By using this script, the main script will have an environment ready for backup.
   It will load, from the $BackupConfigPath folder received as parameter of the main script:
    - common.ps1
    - common_windows.ps1 or common_unix.ps1, depending on the running platform
    - $BackupConfigName like config_template.ps1, received as parameter of the main script
#>

# ----------------------
# LOAD CONFIGS AND CHECKS PRIOR STARTING BACKUP
# ----------------------

# Load common config
$CommonConfigScript = Join-Path $BackupConfigPath "common.ps1"
. $CommonConfigScript

# Load OS common config
if ([environment]::OSVersion.Platform -eq "Win32NT") {
    Write-Output "Current OS: Windows"
    $CommonOSConfigScript = Join-Path $BackupConfigPath "common_windows.ps1"
} else {
    Write-Output "Current OS: Unix"
    $CommonOSConfigScript = Join-Path $BackupConfigPath "common_unix.ps1"
}
. $CommonOSConfigScript

# Load specific config
$BackupConfigScriptFullPath = Join-Path $BackupConfigPath $BackupConfigName
. $BackupConfigScriptFullPath


# ----------------------
# CONFIGURATION
# ----------------------

# Add Dry-Run if enabled, and add to backup log, otherwise remove the variable to avoid a ""
If ($ResticDryRun) {$ResticDryRun = "--dry-run"; "DRY-RUN ACTIVE"} else {Remove-Variable ResticDryRun}

# Add Use FS Snapshot if enabled, otherwise remove the variable to avoid ""
If ($ResticUseFSSnapshot) { $ResticUseFSSnapshot="--use-fs-snapshot"} else {Remove-Variable ResticUseFSSnapshot}

# Find restic and rclone executable, add to path as well
$ResticExecutable = Join-Path $ResticLocation "restic"
$RcloneExecutable = Join-Path $RcloneLocation "rclone"
$Env:PATH += ";" + $ResticLocation
$Env:PATH += ";" + $RcloneLocation
