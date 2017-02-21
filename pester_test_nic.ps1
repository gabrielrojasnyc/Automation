$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-LocalNIC" {
    It "makes sure there is a NIC with the Wi-Fi name present" {
       Get-LocalNICName | Should Be 'Wi-Fi'
    }

    It "returns the MTU size = 1500" {
        Get-LocalNICMTUSize 'Wi-Fi' | Should Be '1500'
    }

    It "makes sure the NIC is set for Full Duplex"{
        Get-LocalNICFullDuplex 'Wi-Fi' | Should BeExactly 'True'
    }

    It "The system name should be $env:computername" {
        Get-LocalNICSystemName 'Wi-Fi' | should Be "$env:computername"
    }

