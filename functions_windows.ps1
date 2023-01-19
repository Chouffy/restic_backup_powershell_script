<#
.Synopsis
   Two helpers functions on Windows for the main script
#>

# Return True if the current session is elevated
function Get-IsCurrentSessionElevated {
    return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Return True if the current network is metered
function Get-IsCurrentNetworkMetered {
    [void][Windows.Networking.Connectivity.NetworkInformation, Windows, ContentType = WindowsRuntime]
    $cost = [Windows.Networking.Connectivity.NetworkInformation]::GetInternetConnectionProfile().GetConnectionCost()
    $cost.ApproachingDataLimit -or $cost.OverDataLimit -or $cost.Roaming -or $cost.BackgroundDataUsageRestricted -or ($cost.NetworkCostType -ne "Unrestricted")
}