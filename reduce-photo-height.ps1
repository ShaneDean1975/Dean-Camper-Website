$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
$pages = @('car-accident-injuries.html','motorcycle-accident-injuries.html','auto-insurance-claims.html','premises-liability.html','defective-product-injuries.html','boat-accident-injuries.html','other-personal-injuries.html','dog-bite-injuries.html')

$count = 0
foreach ($p in $pages) {
    $full = "$path\$p"
    $content = [System.IO.File]::ReadAllText($full)
    $orig = $content

    $content = $content.Replace('max-height:520px;', 'max-height:340px;')
    $content = $content.Replace('height:520px;', 'height:340px;')

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($full, $content)
        $count++
        Write-Host "Updated: $p"
    } else {
        Write-Host "No change: $p"
    }
}
Write-Host "`nDone. Updated $count files."
