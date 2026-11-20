<#
.SYNOPSIS
Collect Sysmon, Defender and host metadata for the EDR laboratory.
#>

param(
    [string]$OutputDirectory = ".\evidence\collected"
)

New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$utc = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")

$metadata = [ordered]@{
    CollectedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    ComputerName = $env:COMPUTERNAME
    OS = (Get-CimInstance Win32_OperatingSystem).Caption
    Build = (Get-CimInstance Win32_OperatingSystem).BuildNumber
    SysmonVersion = if (Test-Path "$env:WinDir\Sysmon64.exe") {
        (Get-Item "$env:WinDir\Sysmon64.exe").VersionInfo.FileVersion
    } else { "not installed" }
}
$metadata | ConvertTo-Json -Depth 4 |
    Set-Content (Join-Path $OutputDirectory "$utc-host.json")

Get-MpComputerStatus |
    ConvertTo-Json -Depth 4 |
    Set-Content (Join-Path $OutputDirectory "$utc-defender.json")

$events = Get-WinEvent -FilterHashtable @{
    LogName = "Microsoft-Windows-Sysmon/Operational"
} -MaxEvents 500
$events | Select-Object TimeCreated, Id, LevelDisplayName, Message |
    ConvertTo-Json -Depth 3 |
    Set-Content (Join-Path $OutputDirectory "$utc-sysmon.json")
