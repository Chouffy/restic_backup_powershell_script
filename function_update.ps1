<#
.Synopsis
   Update restic and rclone binary     
.DESCRIPTION
   Call the self-updaters of both restic and rclone.
   This won't set the capability of the restic executable, so this should be avoided on Linux.
#>

# ----------------------
# RESTIC UPDATE
# ----------------------
Write-Output "`n`n=== STARTING RESTIC UPDATE ===`n"
Start-Process $ResticExecutable -Wait -NoNewWindow -ArgumentList "self-update"

# ----------------------
# RCLONE UPDATE
# ----------------------
Write-Output "`n`n=== STARTING RCLONE UPDATE ===`n"
Start-Process $RcloneExecutable -Wait -NoNewWindow -ArgumentList "self-update"
