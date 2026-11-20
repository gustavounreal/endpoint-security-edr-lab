<#
.SYNOPSIS
Run benign controls for PowerShell, registry persistence and cleanup.
#>

param(
    [switch]$CleanupOnly
)

$labKey = "HKLM:\SOFTWARE\EDR-LAB"

if ($CleanupOnly) {
    Remove-Item -Path $labKey -Recurse -Force -ErrorAction SilentlyContinue
    Write-Output "Cleanup complete"
    exit
}

$text = [Text.Encoding]::Unicode.GetBytes("LAB-EXECUTED-SAFE")
$encoded = [Convert]::ToBase64String($text)
powershell.exe -NoProfile -EncodedCommand $encoded

New-Item -Path $labKey -Force | Out-Null
New-ItemProperty -Path $labKey -Name "Validation" -PropertyType String `
    -Value "LAB-PERSISTENCE-CONTROL" -Force | Out-Null

Write-Output "Controlled PowerShell and registry tests completed"
