write-host "=================================" -ForegroundColor cyan
write-host "      ADPS Menu - Main Menu" -ForegroundColor cyan
write-host "=================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "[i] To quit this script at any time, press CTRL + C"`n -foregroundcolor cyan
write-Host "[i] To re-run this script if it exits, press the up arrow and enter, or if using PS ISE, press F5"`n -foregroundcolor cyan
write-host "                 ERROR!                 "`n -ForegroundColor Black -BackgroundColor Red
Write-Host "Not running as admin - please quit and re-run as admin"`n -ForegroundColor Red
write-host "ADM=$admincheck" -ForegroundColor Black -BackgroundColor Yellow
pause
exit