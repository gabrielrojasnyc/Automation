# you can replace this with list of servers
#$computers  = 1..5 this was for testing purposes
$computers = Get-Content C:\Scripts\test.txt

#Define variable
$DellSystemInfo = $Null

foreach ($node in $computers){
    # Get Dell Server serviceTag
    $ServiceTag1 =(Get-CimInstance -ComputerName $node -ClassName Win32_ComputerSystemProduct).identifyingNumber

    #Defines Dell URL. Notice $servicetag1 variable
    $Url = "https://api.dell.com/support/v2/assetinfo/warranty/tags.xml?svctags=$servicetag1&apikey=d676cf6e1e0ceb8fd14e8cb69acd812d"

    #Connects to Dell API and get correct information based on ProSupport
    [xml]$WarrantyEndDate1 = invoke-webrequest $url -UseBasicParsing
    $WarrantyEndDate2 = ($WarrantyEndDate1.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty |  Where-Object  {$_.ServiceLevelCode -eq 'TS'}).EndDate

    #Cretes an order dictionary table as a  place holder
    $ComputerInfo = [Ordered]@{
                     Computername = $env:COMPUTERNAME
                     ServiceTag = $ServiceTag1
                     WarrantyEndDate = $WarrantyEndDate2
                     }
    #Add info to pscustomobject 
    $DellSystemInfo += @(New-Object pscustomobject -Property $ComputerInfo)
}

Write-Output $DellSystemInfo
