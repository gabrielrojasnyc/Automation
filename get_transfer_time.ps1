#This script finds the tranfer rate of a file at differnt speeds

function Get-TransferTime
{
    [CmdletBinding()]
    Param
    (
        [Long]
        $FileSizeGb,
        $FileSizeTb
    )

    Begin {

        [decimal]$1Gb  = 0.125
        [decimal]$1Mb  = 0.0125
        [long]$10Gb    = 1.250
        [int]$40Gb     = 5
        [long]$100Gb   = 12.5
    }

    Process {
        if($FileSizeTb) { 
            [decimal]$FileSize = $FileSizeTb * 1000
        }
        else { 
            [decimal]$FileSize = $FileSizeGb
        }
        
        $Time1Gb   = $FileSize / $1Gb
        $Time10Gb  = $FileSize / $10Gb
        $Time40Gb  = $FileSize / $40Gb
        $Time100Gb = $FileSize / $100Gb

        $Time1Gb   = New-TimeSpan -Seconds $Time1Gb
        $Time10Gb  = New-TimeSpan -Seconds $Time10Gb
        $Time40Gb  = New-TimeSpan -Seconds $Time40Gb
        $Time100Gb = New-TimeSpan -Seconds $Time100Gb
        $Time1Gb   = $Time1Gb  | Select-Object days, hours, minutes, seconds  
        $Time10Gb  = $Time10Gb | Select-Object days, hours, minutes, seconds
        $Time40Gb  = $Time40Gb | Select-Object days, hours, minutes, seconds
        
    }

    End {
        Write-Output "`n To Transfer $FileSize GB over a 1GB network,  will take $Time1Gb"
        Write-Output "`n To Transfer $FileSize GB over a 10GB network, will take $Time10Gb"
        Write-Output "`n To Transfer $FileSize GB over a 40GB network, will take $Time40Gb"

    }

}
