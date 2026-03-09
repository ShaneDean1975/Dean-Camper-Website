$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$pages = @('shane-dean.html', 'chad-camper.html')
$count = 0

foreach ($p in $pages) {
    $full = "$path\$p"
    $content = [System.IO.File]::ReadAllText($full)
    $orig = $content

    # 1. Hero padding: 120px 40px 80px -> 50px 40px 35px
    $content = $content.Replace("padding: 120px 40px 80px;", "padding: 50px 40px 35px;")

    # 2. Hero content gap: 60px -> 35px
    $content = $content.Replace("gap: 60px;", "gap: 35px;")

    # 3. All four 100px content sections -> 50px
    $content = $content.Replace("padding: 100px 40px;", "padding: 50px 40px;")

    # 4. Hero h1 margin-bottom: 20px -> 12px (unique context in h1 block)
    $content = $content.Replace("font-size: 4rem;`r`n            font-weight: 900;`r`n            margin-bottom: 20px;", "font-size: 3.2rem;`r`n            font-weight: 900;`r`n            margin-bottom: 10px;")
    $content = $content.Replace("font-size: 4rem;`n            font-weight: 900;`n            margin-bottom: 20px;", "font-size: 3.2rem;`n            font-weight: 900;`n            margin-bottom: 10px;")

    # 5. Attorney title margin-bottom: 30px -> 12px
    $content = $content.Replace("font-size: 1.5rem;`r`n            margin-bottom: 30px;", "font-size: 1.4rem;`r`n            margin-bottom: 12px;")
    $content = $content.Replace("font-size: 1.5rem;`n            margin-bottom: 30px;", "font-size: 1.4rem;`n            margin-bottom: 12px;")

    # 6. Hero paragraph margin-bottom: 40px -> 18px
    $content = $content.Replace("font-size: 1.25rem;`r`n            opacity: 0.95;`r`n            margin-bottom: 40px;", "font-size: 1.15rem;`r`n            opacity: 0.95;`r`n            margin-bottom: 18px;")
    $content = $content.Replace("font-size: 1.25rem;`n            opacity: 0.95;`n            margin-bottom: 40px;", "font-size: 1.15rem;`n            opacity: 0.95;`n            margin-bottom: 18px;")

    # 7. Button padding: 18px 40px -> 12px 30px
    $content = $content.Replace("padding: 18px 40px;", "padding: 12px 30px;")

    # 8. Section h2 margin-bottom: 30px -> 15px
    $content = $content.Replace("font-size: 3rem;`r`n            color: var(--primary-navy);`r`n            margin-bottom: 30px;", "font-size: 2.4rem;`r`n            color: var(--primary-navy);`r`n            margin-bottom: 15px;")
    $content = $content.Replace("font-size: 3rem;`n            color: var(--primary-navy);`n            margin-bottom: 30px;", "font-size: 2.4rem;`n            color: var(--primary-navy);`n            margin-bottom: 15px;")

    # 9. Credentials grid margin-top: 50px -> 22px
    $content = $content.Replace("margin-top: 50px;", "margin-top: 22px;")

    # 10. Areas grid margin-top: 40px -> 18px
    $content = $content.Replace("margin-top: 40px;", "margin-top: 18px;")

    # 11. CTA section p margin: 0 auto 40px -> 0 auto 18px
    $content = $content.Replace("margin: 0 auto 40px;", "margin: 0 auto 18px;")

    # 12. CTA h2 margin-bottom: 30px -> 12px (unique context)
    $content = $content.Replace("font-size: 3rem;`r`n            margin-bottom: 30px;", "font-size: 2.4rem;`r`n            margin-bottom: 12px;")
    $content = $content.Replace("font-size: 3rem;`n            margin-bottom: 30px;", "font-size: 2.4rem;`n            margin-bottom: 12px;")

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($full, $content)
        $count++
        Write-Host "Updated: $p"
    } else {
        Write-Host "No change: $p"
    }
}
Write-Host "`nDone. Updated $count files."
