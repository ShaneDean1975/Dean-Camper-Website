$pages = @('car-accident-injuries.html','truck-accident-injuries.html','motorcycle-accident-injuries.html','auto-insurance-claims.html','wrongful-death.html','premises-liability.html','defective-product-injuries.html','boat-accident-injuries.html','other-personal-injuries.html','dog-bite-injuries.html')
$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
foreach ($p in $pages) {
    $full = "$path\$p"
    $content = [System.IO.File]::ReadAllText($full)
    # Search first 20000 chars
    $top = $content.Substring(0, [Math]::Min(20000, $content.Length))
    $matches = [regex]::Matches($top, '<img[^>]+src=["\x27]([^"x27>]+)["\x27][^>]*>')
    if ($matches.Count -gt 0) {
        Write-Host "=== $p ==="
        foreach ($m in $matches) {
            $src = [regex]::Match($m.Value, 'src=["\x27]([^"x27>]+)["\x27]').Groups[1].Value
            Write-Host "  IMG: $src"
        }
    }
    # Also check for page-hero padding
    $heroMatch = [regex]::Match($content, '\.page-hero\s*\{[^}]+\}')
    if ($heroMatch.Success) {
        $padMatch = [regex]::Match($heroMatch.Value, 'padding:[^;]+;')
        Write-Host "  HERO CSS: $($padMatch.Value)"
    }
}
