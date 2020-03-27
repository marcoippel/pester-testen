Import-Module "$PSScriptRoot\Demo.psm1" -Force
InModuleScope Demo {
    Describe "Remove-Items" {

        Mock Remove-Item { }

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
            return @{FullName = "A_File.TXT" }
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

    Describe "Get-Date" {
    
        Mock Get-Date {
            return "02"
        } -Verifiable -ParameterFilter { $format -match "MM" }

        Mock Get-Date { 
            return "01" 
        } -Verifiable -ParameterFilter { $format -match "dd" }

        Mock Get-Date {
            return New-Object datetime (2019, 03, 01)
        } 

        It "get the date" {
            [String] $testResult = GetDate
            $testResult | Should be "03/01/2019 00:00:00"
        }

        It "get the day" {
            [String] $testResult = GetDay
            $testResult | Should be "01"
        }

        It "get the month" {
            [String] $testResult = GetMonth
            $testResult | Should be "02"
        }
    }
}