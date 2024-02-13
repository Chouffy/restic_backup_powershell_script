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
# Check if current session is elevated
If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
   $ResticUseFSSnapshot = $True
} else {
   $ResticUseFSSnapshot = $False
}

# ----------------------
# RCLONE CONFIG
# ----------------------

# Directory where the Rclone executable is 
$RcloneLocation = "C:\Rclone"
