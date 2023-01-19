<#
.Synopsis
   Configuration parameters for the main script, common to all backups on Windows.
#>

# Automatically update restic and rclone
$AutoUpdateApps = $True


# ----------------------
# RESTIC CONFIG
# ----------------------

# Folder containing Restic executable
$ResticLocation = "C:\Restic"

# Restic Backup parameters
$ResticUseFSSnapshot = $True


# ----------------------
# RCLONE CONFIG
# ----------------------

# Directory where the Rclone executable is 
$RcloneLocation = "C:\Rclone"
