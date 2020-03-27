function RemoveFile($path){
    $tempFiles = Get-ChildItem $path
    $tempFiles | Remove-Item
}

function GetFiles($path){
    $tempFiles = Get-ChildItem $path
    return $tempFiles
}

function GetContent($path){
    return Get-Content $path
}