Clear-Host
write-host "====================================" -ForegroundColor cyan
write-host "      ADPS Menu - Disable User" -ForegroundColor cyan
write-host "====================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [6] Disable User"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
write-host "Disable $dispname (y/N)" -nonewline
$disable = read-host " "
if ($disable -eq 'y'){try {
    Disable-ADAccount -Identity "$uname"
    write-host "`nDisabled $dispname"`n -ForegroundColor green
    pause
    . .\SUF
    }
    catch {
        write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
        Write-Host "`nAn error occured - the user has not been disabled`n" -ForegroundColor Red
        write-host "Retry? (y/N)" -NoNewline
        $retry = read-host " "
        if ($retry -eq 'y'){
            . .\DBU.ps1
        }else {
            . .\SUF.ps1
        }
    }
}