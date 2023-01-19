# Restic Backup PowerShell Script

This set of scripts allow the user to launch periodically [restic](https://restic.net) using [PowerShell](https://learn.microsoft.com/en-us/powershell/) from a Windows or Linux environment.

Goals:

- Only one script to maintain different systems and OSes (Windows and Linux)
- One dashboard overview via [HealthChecks.io](https://healthchecks.io/)
- Avoid backup on metered connection (Windows only)
- Do a basic `restic` housekeeping: backup, forget, check
- Simple enough, so I can understand what's going on

Beware that I'm not a PowerShell expert, I've learned along the way.  
I've tested this set of script with PowerShell 7.3 on Windows 10/11, Raspberry Pi OS and Ubuntu Server.

## Overview of user scrips

### `_main_script.ps1`

This script can be called periodically to execute `restic backup`, `restic forget` and `restic check` and must have two parameters:

- `$BackupConfigPath`, which is the *folder* that contains `common_*.ps1` and `config_*.ps1` parameters files
- `$BackupConfigName`, which is the *file name* of the `config_*.ps1` file in the `$BackupConfigPath` which has specific parameters for the backup

Example: `./_main_script.ps1 "/home/restic/config" "config_template.ps1"`

### `_environment_initialize_CLI_call.ps1`

Can be used when the user needs a `restic` environment to do other actions.  
Parameters are the same than `_main_script.ps1`.

Example: `. ./environment_initialize_CLI_call.ps1 ./config/ config_template.ps1; restic stats`

### `_function_update_CLI_call.ps1`

Can be used to start self-update of `restic` and `rclone`.  
Parameters are `/path/to/restic/executable` and `/path/to/rclone/executable`

Example: `sudo pwsh ./function_update_CLI_call.ps1 "/opt/restic/restic" "/opt/rclone/rclone"`

## Setup

1. Have PowerShell installed: built-in on Windows, [see here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux) on Linux
1. `git clone` this repository
1. Create `log/` folder which MUST be in the same folder than the main script
1. Rename and/or move the `config_templates/` to build your own `config/` folder.
    1. The config folder MUST contain `common.ps1`
    1. The config folder MUST contain `common_windows.ps1` or `common_linux.ps1`
    1. The config folder MUST contain the script that will be called in `$BackupConfigName`
1. If you use `rclone`, set-up `common.ps1` with either `rclone.conf` or environment variables for your own configuration
1. Set-up `common_windows.ps1` or `common_unix.ps1` with the path to `restic` and `rclone`.
    1. You can download [restic](https://github.com/restic/restic/releases) and [rclone](https://github.com/rclone/rclone/releases) here, and put the binaries in a fixed folder like `/opt/`
1. Set-up `config_template.ps1` for your own configuration
1. Call `_main_script.ps1 </path/to/config/folder> <config_name.ps1>`
1. Set up `cron` and be happy!
