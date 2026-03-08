$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
$pages = Get-ChildItem -Path $path -Filter "*.html" | Where-Object { $_.Name -notmatch 'COMPLETE|dean-camper-law|chat_config|intake' }

foreach ($file in $pages) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    # Find all img tags and their context (line number equivalent)
    $lines = $content -split "`n"
    $heroImgFound = $false
    for ($i = 0; $i -lt [Math]::Min(200, $lines.Count); $i++) {
        if ($lines[$i] -match '<img[^>]+src=' -and $lines[$i] -notmatch 'display:none|dc-logo') {
            if (-not $heroImgFound) {
                Write-Host "=== $($file.Name) (line ~$i) ==="
                $heroImgFound = $true
            }
            Write-Host "  $($lines[$i].Trim().Substring(0,[Math]::Min(120,$lines[$i].Trim().Length)))"
        }
    }
}
