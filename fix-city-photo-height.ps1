$path = "C:\Users\User\Documents\GitHub\dean-camper-website"
$pages = @(
    'pensacola_car_accident_lawyer_page.html',
    'fort_walton_beach_car_accident_lawyer_page.html',
    'destin_car_accident_lawyer_page.html',
    'crestview_car_accident_lawyer_page.html',
    'mobile_al_car_accident_lawyer_page.html'
)
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
    }
}
Write-Host "`nDone. Updated $count files."
