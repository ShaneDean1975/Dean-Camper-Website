$old = '    <link rel="icon" type="image/svg+xml" href="blue-logo.svg">' + "`n" + '    <link rel="icon" type="image/png" href="dean-camper-logo-new.png">' + "`n" + '    <link rel="apple-touch-icon" href="dean-camper-logo-new.png">'
$new = '    <link rel="icon" type="image/png" href="dc-logo-icon.png">' + "`n" + '    <link rel="apple-touch-icon" href="dc-logo-icon.png">'
$count = 0
Get-ChildItem 'C:\Users\User\Documents\GitHub\dean-camper-website' -Filter '*.html' | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName)
    $normalized = $content -replace "`r`n", "`n"
    if ($normalized.Contains($old)) {
        $replaced = $normalized.Replace($old, $new)
        if ($content.Contains("`r`n")) { $replaced = $replaced -replace "`n", "`r`n" }
        [System.IO.File]::WriteAllText($_.FullName, $replaced, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host "Updated: $($_.Name)"
    } else {
        Write-Host "No match: $($_.Name)"
    }
}
Write-Host "Total updated: $count files"
