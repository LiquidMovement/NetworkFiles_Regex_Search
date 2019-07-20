$content = import-csv C:\temp\test.csv -header c1,c2

$dataroot = "S:\Team Drives"
$datalocation = "$dataroot\<SHARED DRIVE>\<PATH>"

$datadestination = "\\<NETWORK PATH>\CJCheckTest\"

for($i=0;$i -lt $content.length;$i++){
    $jn = $content[$i].c1
    $check = $content[$i].c2

	if(test-path "$datadestination\$jn"){
		Write-Host "$datadestination\$jn Already exists"
		$destfile = "$datadestination\$jn"
	}else{
		New-Item "$datadestination\$jn" -Type Directory -Force
		$destfile = "$datadestination\$jn"
	}

    $tester = "chk#$check"
    	
    Get-ChildItem "$datalocation" -recurse $tester* | foreach{
		if($_.Name -match "$tester(?!\d)"){
			$nextname = Join-path -path $destfile -childpath $_.Name
			$num = 1
			while(test-path -path $nextname){
				$nextname = Join-path $destfile($_.BaseName + "_$num" + $_.Extension)
				$num += 1
			}
			$_ | Copy-Item -Destination $nextname -recurse
		}
        Get-ChildItem $destfile -recurse
	}
}