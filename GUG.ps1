Clear-Host
write-host "=======================================" -ForegroundColor cyan
write-host "      ADPS Menu - Get User Groups" -ForegroundColor cyan
write-host "=======================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / Remove User from Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
Pause
Clear-Host
write-host "=======================================" -ForegroundColor cyan
write-host "      ADPS Menu - Get User Groups" -ForegroundColor cyan
write-host "=======================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / Remove User from Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
write-host "Getting groups for $dispname"`n -ForegroundColor Yellow
    try{
        Get-ADPrincipalGroupMembership -Identity $uname | Select-Object name | Sort-Object name
    }
    catch{
    Clear-Host
    write-host "=======================================" -ForegroundColor cyan
    write-host "      ADPS Menu - Get User Groups" -ForegroundColor cyan
    write-host "=======================================" -ForegroundColor cyan
    write-host "        $startdate"`n -ForegroundColor cyan
    write-host "Selected Function: [1] User Functions / Remove User from Group"`n -foregroundcolor cyan
    write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
    Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
    write-host "This will cause the script to exit once run - to re-run, press the up arrow and enter"`n -ForegroundColor Yellow
    write-host "Getting groups for $dispname"`n -ForegroundColor Yellow
    write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
    Write-Host "`nAn error occured - unable to retrieve groups for $dispname`n" -ForegroundColor red
    Pause
    . .\SUF.ps1
}