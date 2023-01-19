<#
.Synopsis
   Initialize a restic environment for CLI user     

.DESCRIPTION
   By using this script, a user can have a CLI configured for restic/rclone usage.
   It will have the same configuration & environment variable as the scripted backup.
   This can be used to access easily some commands like restic stats

.EXAMPLE
   . ./environment_initialize_CLI_call.ps1 ./config/ config_template.ps1
   restic stats
   
#>


[CmdletBinding()]
param(
    [Parameter(Position=0, mandatory=$true)]
    [String]$BackupConfigPath,  # Config file like "path/to/config/" 
    [Parameter(Position=1, mandatory=$true)]
    [String]$BackupConfigName  # Config file like "config_file.ps1" 
)

# Configuration
$InitializeEnvironmentScript = Join-Path $PSScriptRoot "environment_initialize.ps1"
. $InitializeEnvironmentScript  # No need to pass variable as we are on the same scope
