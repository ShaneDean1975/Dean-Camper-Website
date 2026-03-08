$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
$pages = Get-ChildItem -Path $path -Filter "*.html"

foreach ($file in $pages) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content -match 'background-image|background.*url\(') {
        $lines = $content -split "`n"
        Write-Host "=== $($file.Name) ==="
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match 'background-image|background.*url\(') {
                Write-Host "  L$($i+1): $($lines[$i].Trim())"
            }
        }
    }
}
