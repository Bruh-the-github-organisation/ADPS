Clear-Host
write-host "======================================" -ForegroundColor cyan
write-host "      ADPS Menu - User Functions" -ForegroundColor cyan
write-host "======================================" -ForegroundColor cyan
write-host "        $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "[1]  Select User"
Write-Host "[2]  Get Members of group"`n
Write-Host "Enter a number" -NoNewline
$UserFChoice = Read-Host " "
# If user inputs 'exit', go back to previous page
if ($UserFChoice -eq 'exit'){
    clear-variable group
    Clear-Variable DC
    Clear-Variable dispname
    Clear-Variable uname
    Clear-Variable SU
    Clear-Variable mmchoice
    Clear-Variable UserFChoice
    . .\adps-main.ps1
}

if ($UserFChoice -eq '1'){
    Clear-Variable UserFChoice
    . .\SU.ps1
}elseif ($UserFChoice -eq '2'){
        Clear-Variable UserFChoice
        . .\GMG.ps1
}else{
    . .\UserF.ps1
}