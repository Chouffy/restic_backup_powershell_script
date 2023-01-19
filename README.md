# Restic Backup PowerShell Script

This set of scripts allow the user to launch periodically [restic](https://restic.net) using [PowerShell](https://learn.microsoft.com/en-us/powershell/) from a Windows or Linux environment.

Goals:

- Only one script to maintain different systems and OSes (Windows and Linux)
- One dashboard overview via [HealthChecks.io](https://healthchecks.io/)
- Avoid backup on metered connection (Windows only)
- Simple enough, so I can understand what's going on

Tested on:

- Windows 10
- Windows 11
- Raspberry Pi OS
- Ubuntu Server

## Overview of user scrips

### `_main_script.ps1`

This script can be called periodically to execute `restic backup`, `restic forget` and `restic check` and must have two parameters:

- `$BackupConfigPath`, which is the *folder* that contains `common_*.ps1` and `config_*.ps1` parameters files
- `$BackupConfigName`, which is the *file name* of the `config_*.ps1` file in the `$BackupConfigPath` which has specific parameters for the backup

Example: `./_main_script.ps1 "/home/restic/config" "config_template.ps1"`

### `_environment_initialize_CLI_call.ps1`

Can be used when the user needs a `restic` environment to do other actions.
Example: `. ./environment_initialize_CLI_call.ps1 ./config/ config_template.ps1; restic stats`

### `_function_update_CLI_call.ps1`

Can be used to start self-update of `restic` and `rclone`.  
Example: `sudo pwsh ./function_update_CLI_call.ps1 "/opt/restic/restic" "/opt/rclone/rclone"`

## Setup

1. Create `log/` folder which MUST be in the same folder than the main script
1. Rename and/or move the `config_templates/` to build your own `config/` folder.
    1. The config folder MUST contain `common.ps1`
    1. The config folder MUST contain `common_windows.ps1` or `common_linux.ps1`
    1. The config folder MUST contain the script that will be called in `$BackupConfigName`
1. Set-up `config_template.ps1` for your own configuration
1. If you use `rclone`, set-up `common.ps1` with either `rclone.conf` or environment variables for your own configuration
1. Call `_main_script.ps1 </path/to/config/folder> <config_name.ps1>`
1. Set up `cron` and be happy!
