Clear-Host
write-host "============================================" -ForegroundColor cyan
write-host "      ADPS Menu - Get Members of group" -ForegroundColor cyan
write-host "============================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [2] Get Members of Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
Pause
$DC = get-addomaincontroller | Select-Object -ExpandProperty hostname
Clear-Host
write-host "============================================" -ForegroundColor cyan
write-host "      ADPS Menu - Get Members of group" -ForegroundColor cyan
write-host "============================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [2] Get Members of Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
$group = read-host "Group"
if (dsquery group -name $group){
    try{
        Get-ADgroup -Identity "$group" | Get-ADGroupMember | select-object name | Sort-Object name
    }
    catch{
    Clear-Host
    write-host "============================================" -ForegroundColor cyan
    write-host "      ADPS Menu - Get Members of group" -ForegroundColor cyan
    write-host "============================================" -ForegroundColor cyan
    write-host "        $startdate"`n -ForegroundColor cyan
    write-host "Selected Function: [1] User Functions > [2] Get Members of Group"`n -foregroundcolor cyan
    write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
    write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
    write-host "Getting members of $group"`n -ForegroundColor Yellow
    write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
    Write-Host "`nAn error occured - unable to retreive members of $group`n" -ForegroundColor red
    Pause
    . .\GMG.ps1
    }
}else{
    Clear-Host
write-host "============================================" -ForegroundColor cyan
write-host "      ADPS Menu - Get Members of group" -ForegroundColor cyan
write-host "============================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [2] Get Members of Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
write-host "Group Validation: " -nonewline; write-host "FAIL" -ForegroundColor Red
Write-Host "Cannot find '$group' on $dc"`n
Pause
. .\UserF.ps1
}