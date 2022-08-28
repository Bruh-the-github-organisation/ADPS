Clear-Host
write-host "===================================" -ForegroundColor cyan
write-host "      ADPS Menu - Enable User" -ForegroundColor cyan
write-host "===================================" -ForegroundColor cyan
write-host "       $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [5] Enable User"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
write-host "Enable $dispname (y/N)" -nonewline
$enable = read-host " "
if ($enable -eq 'y'){try {
    Enable-ADAccount -Identity "$uname"
    write-host "`nEnabled $dispname"`n -ForegroundColor green
    pause
    . .\SUF
    }
    catch {
        write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
        Write-Host "`nAn error occured - the user has not been enabled`n" -ForegroundColor red
        write-host "Retry? (y/N)" -NoNewline
        $retry = read-host " "
        if ($retry -eq 'y'){
            . .\ENU.ps1
        }else {
            . .\SUF.ps1
        }
    }
}