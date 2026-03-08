$tmp = [System.IO.Path]::GetTempPath()
Write-Host "Temp path: $tmp"
$files = Get-ChildItem $tmp -Filter "*.tmp" | Sort-Object LastWriteTime -Descending | Select-Object -First 8
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $sig = ""
    if ($bytes.Length -ge 4) {
        if ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xD8) { $sig = "JPEG" }
        elseif ($bytes[0] -eq 0x89 -and $bytes[1] -eq 0x50) { $sig = "PNG" }
        else { $sig = "Other" }
    }
    Write-Host "$($f.Name) | $($f.Length) bytes | $($f.LastWriteTime) | $sig"
}
