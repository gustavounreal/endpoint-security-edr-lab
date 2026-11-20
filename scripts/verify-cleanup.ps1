$labKey = "HKLM:\SOFTWARE\EDR-LAB"
$exists = Test-Path $labKey

$result = [ordered]@{
    CheckedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    Host = $env:COMPUTERNAME
    LabRegistryKey = $labKey
    KeyExists = $exists
}

$result | ConvertTo-Json -Depth 3
