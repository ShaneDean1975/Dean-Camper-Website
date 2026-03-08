$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$files = Get-ChildItem -Path $path -Filter "*.html"
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $orig = $content

    $content = $content.Replace("Pensacola, FL &mdash; (850) 433-3077", "Pensacola, FL")
    $content = $content.Replace("Fort Walton Beach, FL &mdash; (850) 796-3077", "Fort Walton Beach, FL")
    $content = $content.Replace("Destin, FL &mdash; (850) 269-7105", "Destin, FL")
    $content = $content.Replace("Crestview, FL &mdash; (850) 796-3077", "Crestview, FL")
    $content = $content.Replace("Mobile, AL &mdash; (251) 283-0577", "Mobile, AL")

    if ($content -ne $orig) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $count++
        Write-Host "Updated: $($file.Name)"
    }
}
Write-Host "`nDone. Updated $count files."
