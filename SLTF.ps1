Clear-Host
write-host "==================================" -ForegroundColor cyan
write-host "      ADPS Menu - S/L/T Menu" -ForegroundColor cyan
write-host "==================================" -ForegroundColor cyan
write-host "       $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / [3] S/L/T Menu"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
# Show menu for S/L/T functions
write-host "[1] Starter"
write-host "[2] Transfer"
write-host "[3] Leaver"`n
$sltchoice = read-host "Enter a number"
if ($sltchoice -eq '1'){
    . .\sltstarter.ps1
}elseif($sltchoice -eq '2'){
    . .\slttransfer.ps1
}elseif($sltchoice -eq '3'){
    . .\sltleaver.ps1
}elseif($sltchoice -eq 'exit'){
    . .\adps-main.ps1
}else{. .\sltf.ps1}