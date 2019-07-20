
$datasource = get-content "\\<NETWORK PATH>\jns to pull\All_jns.txt" #list of jn #'s to be found

$dataroot = "\\<NETWORK PATH>"

$datalocation = "$dataroot\<FOLDER>" #what data set to look at

$datadestination = "\\<NETWORK PATH>\"  #data destination before HDD
$log = "$datadestination\Log.txt"

foreach($jn in $datasource){
    
    if(test-path "$datadestination\$jn"){
        Write-Host "Already exists - $jn"
        $DestFile = "$datadestination\$jn"
    }
    else{
        New-Item "$datadestination\$jn" -Type Directory -Force
        $DestFile = "$datadestination\$jn"
    }
    
    $0jn = "0$jn"
    Get-ChildItem "$datalocation" -Recurse $0jn* | ForEach{
        if ($_.Name -match "^\d{6,6}(?!\d)") {
            $nextName = Join-Path -Path $destFile -ChildPath $_.Name
            $num = 1

            while(test-path -Path $nextName){
                $nextname = Join-Path $destFile ($_.BaseName + "_$num" + $_.Extension)
                $num += 1
            }
            $_ | Copy-Item -Destination $nextName -Recurse
        }
        Get-ChildItem "$DestFile" -Recurse

    }
}