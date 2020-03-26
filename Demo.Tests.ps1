Import-Module '.\Demo.ps1'
# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here\$sut"

Describe "Remove-Items" {

    Mock Remove-Item {

    }

    New-Item TestDrive:/test.txt
    New-Item TestDrive:/demo.txt

    $testResult = RemoveFile -path TestDrive:\

    It "adds positive numbers" {
        Assert-MockCalled Remove-Item -Times 2 -Exactly
    }
}

Describe "Get-Items" {

    Mock Get-ChildItem {
        return @{FullName = "A_File.TXT"}
    }

    [HashTable] $testResult = GetFiles -path TestDrive:\ 
    Write-Host $testResult.FullName

    It "get total files" {
        $testResult.FullName | Should be "A_File.TXT"
        Assert-MockCalled Get-ChildItem -Times 1 -Exactly
    }
}