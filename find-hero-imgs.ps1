$pages = @('car-accident-injuries.html','truck-accident-injuries.html','motorcycle-accident-injuries.html','auto-insurance-claims.html','wrongful-death.html','premises-liability.html','defective-product-injuries.html','boat-accident-injuries.html','other-personal-injuries.html')
$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
foreach ($p in $pages) {
    $full = "$path\$p"
    $content = [System.IO.File]::ReadAllText($full)
    $top = $content.Substring(0, [Math]::Min(8000, $content.Length))
    $matches = [regex]::Matches($top, '<img[^>]+>')
    if ($matches.Count -gt 0) {
        Write-Host "=== $p ==="
        foreach ($m in $matches) {
            $val = $m.Value
            if ($val.Length -gt 150) { $val = $val.Substring(0,150) + "..." }
            Write-Host "  $val"
        }
    } else {
        Write-Host "=== $p === (no images in top 8000 chars)"
    }
}
