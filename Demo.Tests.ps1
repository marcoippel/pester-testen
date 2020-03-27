Import-Module "$PSScriptRoot.\Demo.ps1" -Force
# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here\$sut"

Describe "Remove-Items" {

    Mock Remove-Item {}

    New-Item TestDrive:/test.txt
    New-Item TestDrive:/demo.txt

    It "Remove files" {
        $testResult = RemoveFile -path TestDrive:\
        $testResult | Should be $null
        Assert-MockCalled Remove-Item -Times 2 -Exactly
    }
}

Describe "Get-Items" {
    
    Mock Get-ChildItem {
        return @{FullName = "A_File.TXT"}
    }

    It "get total files" {
        [HashTable] $testResult = GetFiles -path TestDrive:\ 
        $testResult.FullName | Should be "A_File.TXT"
        Assert-MockCalled Get-ChildItem -Times 1 -Exactly
    }
}

Describe "Get-Content" {
    
    Mock Get-Content {
        return "Demo content"
    } -ParameterFilter { $Path -and $Path.StartsWith("TestDrive:\demo.txt") }

    Mock Get-Content {
        return "Other content"
    } -ParameterFilter { $Path -and $Path.StartsWith("TestDrive:\other.txt") }

    It "get content of file" {
        [String] $testResult = GetContent -path TestDrive:\demo.txt 
        $testResult | Should be "Demo content"
    }

    It "get content of file" {
        [String] $testResult = GetContent -path TestDrive:\other.txt 
        $testResult | Should be "Other content"
    }
}