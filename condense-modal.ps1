$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$files = Get-ChildItem -Path $path -Filter "*.html"
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content -notmatch "eval-modal-overlay") { continue }
    $orig = $content

    # 1. Overlay padding: 1rem -> 0.5rem
    $content = $content.Replace("            justify-content: center;`r`n            padding: 1rem;", "            justify-content: center;`r`n            padding: 0.5rem;")
    $content = $content.Replace("            justify-content: center;`n            padding: 1rem;", "            justify-content: center;`n            padding: 0.5rem;")

    # 2. Header padding: 1.4rem 2rem 1.2rem -> 0.85rem 1.5rem 0.7rem
    $content = $content.Replace("padding: 1.4rem 2rem 1.2rem;", "padding: 0.85rem 1.5rem 0.7rem;")

    # 3. Header h3 font-size: 1.45rem -> 1.15rem
    $content = $content.Replace("font-size: 1.45rem;", "font-size: 1.15rem;")

    # 4. Header h3 margin: reduce bottom spacing
    $content = $content.Replace("margin: 0 2.5rem 0.3rem 0;", "margin: 0 2.5rem 0.05rem 0;")

    # 5. Modal body padding: 1.8rem 2rem -> 0.9rem 1.5rem
    $content = $content.Replace(".eval-modal-body { padding: 1.8rem 2rem; }", ".eval-modal-body { padding: 0.9rem 1.5rem; }")

    # 6. Form grid gap + margin-bottom (they appear on consecutive lines)
    $content = $content.Replace("            gap: 1.1rem;`r`n            margin-bottom: 1.2rem;", "            gap: 0.5rem;`r`n            margin-bottom: 0.5rem;")
    $content = $content.Replace("            gap: 1.1rem;`n            margin-bottom: 1.2rem;", "            gap: 0.5rem;`n            margin-bottom: 0.5rem;")

    # 7. Form group gap: 0.35rem -> 0.15rem
    $content = $content.Replace("display: flex; flex-direction: column; gap: 0.35rem; }", "display: flex; flex-direction: column; gap: 0.15rem; }")

    # 8. Input/select/textarea padding: 0.65rem 0.9rem -> 0.38rem 0.75rem
    $content = $content.Replace("            padding: 0.65rem 0.9rem;", "            padding: 0.38rem 0.75rem;")

    # 9. Input/select/textarea font-size: 0.95rem -> 0.88rem (target unique context)
    $content = $content.Replace("            font-size: 0.95rem;`r`n            font-family: 'Work Sans', sans-serif;`r`n            color: #0f1419;", "            font-size: 0.88rem;`r`n            font-family: 'Work Sans', sans-serif;`r`n            color: #0f1419;")
    $content = $content.Replace("            font-size: 0.95rem;`n            font-family: 'Work Sans', sans-serif;`n            color: #0f1419;", "            font-size: 0.88rem;`n            font-family: 'Work Sans', sans-serif;`n            color: #0f1419;")

    # 10. Textarea min-height: 88px -> 52px
    $content = $content.Replace("min-height: 88px; }", "min-height: 52px; }")

    # 11. Submit button padding + font-size (consecutive properties)
    $content = $content.Replace("            padding: 1rem 2rem;`r`n            font-size: 1.05rem; font-weight: 700;", "            padding: 0.6rem 2rem;`r`n            font-size: 0.95rem; font-weight: 700;")
    $content = $content.Replace("            padding: 1rem 2rem;`n            font-size: 1.05rem; font-weight: 700;", "            padding: 0.6rem 2rem;`n            font-size: 0.95rem; font-weight: 700;")

    # 12. Form note margin-top: 0.9rem -> 0.35rem
    $content = $content.Replace("font-size: 0.84rem; margin-top: 0.9rem;", "font-size: 0.82rem; margin-top: 0.35rem;")

    # 13. Mobile query body padding: 1.2rem -> 0.75rem
    $content = $content.Replace(".eval-modal-body { padding: 1.2rem; }", ".eval-modal-body { padding: 0.75rem; }")

    # 14. Mobile query header padding: 1.1rem 1.2rem -> 0.65rem 1rem
    $content = $content.Replace(".eval-modal-header { padding: 1.1rem 1.2rem; }", ".eval-modal-header { padding: 0.65rem 1rem; }")

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $count++
        Write-Host "Updated: $($file.Name)"
    }
}
Write-Host "`nDone. Updated $count files."
