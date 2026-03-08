$path = 'C:\Users\User\Documents\GitHub\dean-camper-website'
$pages = @('car-accident-injuries.html','truck-accident-injuries.html','motorcycle-accident-injuries.html','auto-insurance-claims.html','wrongful-death.html','premises-liability.html','defective-product-injuries.html','boat-accident-injuries.html','other-personal-injuries.html','dog-bite-injuries.html')

foreach ($p in $pages) {
    $content = [System.IO.File]::ReadAllText("$path\$p")
    $lines = $content -split "`n"
    # Find end of badge section
    $badgeEnd = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match 'badges-section|badges-track|badge-img') {
            $badgeEnd = $i
        }
    }
    if ($badgeEnd -ge 0) {
        # Look at next 60 lines after badge section
        $start = $badgeEnd + 1
        $end = [Math]::Min($start + 60, $lines.Count)
        for ($i = $start; $i -lt $end; $i++) {
            if ($lines[$i] -match '<img|height.*px|\.hero-img|hero-photo|practice-img|intro-img|content.*img') {
                Write-Host "=== $p L$($i+1): $($lines[$i].Trim().Substring(0,[Math]::Min(150,$lines[$i].Trim().Length)))"
            }
        }
    }
}
