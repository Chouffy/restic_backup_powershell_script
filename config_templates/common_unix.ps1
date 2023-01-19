<#
.Synopsis
   Configuration parameters for the main script, common to all backups on Linux.
#>

# Automatically update restic and rclone
$AutoUpdateApps = $False  # Disabled on Linux systems as you need to do `setcap` as root


# ----------------------
# RESTIC CONFIG
# ----------------------

# Folder containing Restic executable
$ResticLocation = "/opt/restic"

# Restic Backup parameters
$ResticUseFSSnapshot = $False # At the moment, this uses Windows VSS only


# ----------------------
# RCLONE CONFIG
# ----------------------

# Directory where the Rclone executable is 
$RcloneLocation = "/opt/rclone"
