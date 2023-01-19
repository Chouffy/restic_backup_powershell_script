<#
.Synopsis
   Update restic and rclone binary     
.DESCRIPTION
   Call the self-updaters of both restic and rclone by a CLI user
.EXAMPLE
   sudo pwsh ./function_update_CLI_call.ps1 "/opt/restic/restic" "/opt/rclone/rclone"
#>

[CmdletBinding()]
param(
    [Parameter(Position=0, mandatory=$true)]
    [String]$ResticExecutable,  # Restic executable, like "/opt/restic/restic"
    [Parameter(Position=1, mandatory=$true)]
    [String]$RcloneExecutable   # Rclone executable, like "/opt/rclone/rclone" 
)

# Configuration
$UpdateScript = Join-Path $PSScriptRoot "function_update.ps1"
. $UpdateScript  


# On Linux, the `setcap` attribute must be re set if the Restic executable has been updated
# See https://restic.readthedocs.io/en/stable/080_examples.html#full-backup-without-root
if ([environment]::OSVersion.Platform -eq "Unix") {
   Write-Output "`n`n=== RESTIC SETCAP ===`n"
    Write-Output "Unix environment: trying to call setcap"
    Write-Output "This will fail if the current user isn't sudo/root"
    setcap cap_dac_read_search=+ep $ResticExecutable
}

