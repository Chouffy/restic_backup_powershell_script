<#
.Synopsis
   Configuration parameters for the main script, for one backup.
#>

# Restic configuration specific to this config
$ResticDryRun = $False

# Folder to be backed up, like "path\to\folder"
$ResticBackupFolder = "/path/to/input/folder"

# Restic repo
#   rclone:repo_name:path
#   local:drive:\path\to\folder
$Env:RESTIC_REPOSITORY="local:/path/to/remote"

# Repo password - beware of escape characters
$Env:RESTIC_PASSWORD="abc123"

# Healthchecks.io Links
$HealthChecksBackupLink="https://hc-ping.com/<UUID>"
$HealthChecksForgetLink="https://hc-ping.com/<UUID>"
$HealthChecksCheckLink="https://hc-ping.com/<UUID>"
