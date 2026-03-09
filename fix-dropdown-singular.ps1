$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$files = Get-ChildItem -Path $path -Filter "*.html"
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $orig = $content

    $content = $content.Replace("Injuries</option>", "Injury</option>")
    $content = $content.Replace("Claims</option>", "Claim</option>")

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $count++
        Write-Host "Updated: $($file.Name)"
    }
}
Write-Host "`nDone. Updated $count files."
