$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
$pages = @('car-accident-injuries.html','truck-accident-injuries.html','motorcycle-accident-injuries.html','auto-insurance-claims.html','wrongful-death.html','premises-liability.html','defective-product-injuries.html','boat-accident-injuries.html','other-personal-injuries.html','dog-bite-injuries.html')

foreach ($p in $pages) {
    $content = [System.IO.File]::ReadAllText("$path\$p")
    $lines = $content -split "`n"
    $found = @()
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '<img') {
            $found += "  L$($i+1): $($lines[$i].Trim().Substring(0,[Math]::Min(130,$lines[$i].Trim().Length)))"
        }
    }
    if ($found.Count -gt 0) {
        Write-Host "=== $p ($($found.Count) images) ==="
        $found | Select-Object -First 10 | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "=== $p === NO IMAGES"
    }
}
