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

function GetDate(){
    $date = Get-Date
    return $date
}

function GetDay(){
    $date = Get-Date -f "dd"
    return $date
}

function GetMonth(){
    $date = Get-Date -f "MM"
    return $date
}

function Calculate($number1, $number2) {
    return $number1 + $number2
}