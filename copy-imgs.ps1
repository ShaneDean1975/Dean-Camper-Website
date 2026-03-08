$tmp = "C:\Users\User\AppData\Local\Temp"
$dest = "C:\Users\User\Documents\GitHub\dean-camper-website"

# Copy using stream to handle locked files
$files = @(
    @{src="$tmp\c7236e45-30fc-4813-87fa-ea852ebffab0.tmp"; dst="$dest\uploaded_img1.jpg"},
    @{src="$tmp\6f827435-bc18-47ad-a7bb-f5e5435655af.tmp"; dst="$dest\uploaded_img2.dat"}
)

foreach ($f in $files) {
    try {
        $src = [System.IO.File]::Open($f.src, 'Open', 'Read', 'ReadWrite')
        $dst = [System.IO.File]::Create($f.dst)
        $src.CopyTo($dst)
        $src.Close(); $dst.Close()
        Write-Host "Copied: $($f.src) -> $($f.dst)"
    } catch {
        Write-Host "Failed: $($f.src) - $_"
    }
}
