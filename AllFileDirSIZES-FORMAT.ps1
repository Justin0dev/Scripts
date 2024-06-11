Function Convert-Size($bytes) {
    if ($bytes -gt 1GB) {
        "{0:N2} GB" -f ($bytes / 1GB)
    } elseif ($bytes -gt 1MB) {
        "{0:N2} MB" -f ($bytes / 1MB)
    } elseif ($bytes -gt 1KB) {
        "{0:N2} KB" -f ($bytes / 1KB)
    } else {
        "{0:N2} bytes" -f $bytes
    }
}

Get-ChildItem -Directory | ForEach-Object {
    $folder = $_
    $size = (Get-ChildItem $folder.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum
    $sizeString = Convert-Size $size
    "$sizeString - $folder.Name"
}
Pause