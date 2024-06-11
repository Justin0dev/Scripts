Get-ChildItem -Filter *.mp3 | ForEach-Object {
    $newName = $_.CreationTime.ToString("HHmm") + '.mp3'
    Rename-Item $_.FullName -NewName $newName
}
