<#
.Synopsis
   Configuration parameters for the main script, common to all OS and backups.   
#>

# ----------------------
# RESTIC CONFIG
# ----------------------

# Restic Backup parameters
$ResticBackupTag = "automated-backup"
$ResticExcludeIfPresent = ".backupignore"
$ResticDryRun = $False

# Restic Forget parameters - See https://restic.readthedocs.io/en/stable/060_forget.html#removing-snapshots-according-to-a-policy
$ResticForgetKeepLast=10
$ResticForgetKeepDaily=7
$ResticForgetKeepWeekly=5
$ResticForgetKeepMonthly=12
$ResticForgetKeepYearly=75

# Restic Check parameter
$ResticCheckReadDataSubset="100M"

# ----------------------
# RCLONE CONFIG
# ----------------------

# Rclone config via a file
#$Env:RCLONE_CONFIG=Join-Path $PSScriptRoot "rclone.conf"

# Rclone config via environment variables - See the rclone doc - Beware to add ` before " !
$Env:RCLONE_CONFIG_ENDPOINT_KEY=value
