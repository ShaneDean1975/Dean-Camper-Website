$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$filter = "brightness(0) saturate(100%) invert(17%) sepia(96%) saturate(6669%) hue-rotate(354deg) brightness(72%) contrast(109%)"
$files = Get-ChildItem -Path $path -Filter "*.html"
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $orig = $content

    # 1. Add filter to .site-mobile-phone on pages that don't already have it
    $oldPhone = ".site-mobile-phone{display:flex!important;align-items:center!important;color:#c8102e!important;font-size:1.6rem!important;text-decoration:none!important;line-height:1!important;}"
    $newPhone = ".site-mobile-phone{display:flex!important;align-items:center!important;color:#c8102e!important;font-size:1.6rem!important;text-decoration:none!important;line-height:1!important;filter:$filter!important;}"
    $content = $content.Replace($oldPhone, $newPhone)

    # 2. Add .nav-phone-emoji CSS rule inside the media query (before closing brace)
    # Handle both CRLF and LF
    $oldEnd = ".site-dropdown>a{touch-action:manipulation!important;}`r`n        }"
    $newEnd = ".site-dropdown>a{touch-action:manipulation!important;}`r`n            .nav-phone-emoji{filter:$filter!important;display:inline-block!important;}`r`n        }"
    $content = $content.Replace($oldEnd, $newEnd)

    $oldEndLF = ".site-dropdown>a{touch-action:manipulation!important;}`n        }"
    $newEndLF = ".site-dropdown>a{touch-action:manipulation!important;}`n            .nav-phone-emoji{filter:$filter!important;display:inline-block!important;}`n        }"
    $content = $content.Replace($oldEndLF, $newEndLF)

    # 3. Wrap the dropdown emoji in a span (HTML)
    $oldSpan = ">&#128222; Call Now</a>"
    $newSpan = "><span class=`"nav-phone-emoji`">&#128222;</span> Call Now</a>"
    $content = $content.Replace($oldSpan, $newSpan)

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $count++
        Write-Host "Updated: $($file.Name)"
    } else {
        Write-Host "No change: $($file.Name)"
    }
}
Write-Host "`nDone. Updated $count files."
