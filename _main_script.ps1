<#
.Synopsis
   Automated script to run restic backup, forget, check.   

.DESCRIPTION
   See the README

   Parameters:

    - $BackupConfigPath: folder that contains config files, like "/path/to/config".
      This folder must contain:
       - common.ps1
       - common_windows.ps1 and common_unix.ps1
       - config_SPECIFIC.ps1

    - $BackupConfigName: config_SPECIFIC.ps1 file for the specific backup, like "config_template.ps1"

   It also relies on all the scripts in the current script folder.

.EXAMPLE
   ./_main_script.ps1 "/home/restic/config" "config_template.ps1"
#>

# ----------------------
# PARAMETERS
# ----------------------

[CmdletBinding()]
param(
    [Parameter(Position=0, mandatory=$true)]
    [String]$BackupConfigPath,
    [Parameter(Position=1, mandatory=$true)]
    [String]$BackupConfigName
)

# ----------------------
# DEPENDENCIES LOADING
# ----------------------

# Configuration
$InitializeEnvironmentScript = Join-Path $PSScriptRoot "environment_initialize.ps1"
. $InitializeEnvironmentScript  # No need to pass variable as we are on the same scope

# Functions
$FunctionsScript = Join-Path $PSScriptRoot "functions_windows.ps1"
. $FunctionsScript

# Logging
$InitializeLogsScript = Join-Path $PSScriptRoot "log_initialize.ps1"
. $InitializeLogsScript


# ----------------------
# CHECKS PRIOR STARTING BACKUP
# ----------------------

# Load OS common config
if ([environment]::OSVersion.Platform -eq "Win32NT") {
    # Check if current session is elevated
    If (-not (Get-IsCurrentSessionElevated) ) {
        Write-Warning "Current session isn't elevated, error could happens."
    }

    # Check if current connection is metered
    If (Get-IsCurrentNetworkMetered) {
        Write-Warning "Current network is metered, exiting."
        exit
    }
}

# ----------------------
# UPDATE RESTIC AND RCLONE
# ----------------------
if ($AutoUpdateApps) {
    $BackupScript = Join-Path $PSScriptRoot "function_update.ps1"
    . $BackupScript
} else {Write-Output "`nSkip auto-update`n"}

# ----------------------
# RESTIC BACKUP
# ----------------------
$BackupScript = Join-Path $PSScriptRoot "restic_backup.ps1"
. $BackupScript

# ----------------------
# RESTIC FORGET, CHECK AND CLEAN LOG
# ----------------------
$BackupScript = Join-Path $PSScriptRoot "restic_forget.ps1"
. $BackupScript

$BackupScript = Join-Path $PSScriptRoot "restic_check.ps1"
. $BackupScript

$BackupScript = Join-Path $PSScriptRoot "log_directory_cleanup.ps1"
. $BackupScript

# $BackupScript = Join-Path $PSScriptRoot "restic_stats.ps1"
# . $BackupScript