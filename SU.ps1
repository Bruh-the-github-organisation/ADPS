Clear-Host
write-host "===================================" -ForegroundColor cyan
write-host "      ADPS Menu - Select User" -ForegroundColor cyan
write-host "===================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
write-host "Enter user" -NoNewline
$SU = read-host " "
# If user inputs 'exit', go back to previous page
if ($su -eq 'exit'){
    clear-variable group
    Clear-Variable DC
    Clear-Variable dispname
    Clear-Variable uname
    Clear-Variable SU
    Clear-Variable mmchoice
    Clear-Variable UserFChoice
    . .\UserF.ps1
}
$dispname = get-aduser -Filter { displayName -like $SU } | Select-Object -ExpandProperty name -ErrorAction SilentlyContinue
$uname = get-aduser -Filter { displayName -like $SU } | Select-Object -ExpandProperty samaccountname -ErrorAction SilentlyContinue


$DC = get-addomaincontroller | Select-Object -ExpandProperty hostname

# Checks if user is valid by looking up the user by display name
if (dsquery user -name $su){}

# If user is not valid (i.e doesn't exist under display name) display a custom error message, prompting the user to press enter to retry
else{
    clear-host
    write-host "===================================" -ForegroundColor cyan
    write-host "      ADPS Menu - Select User" -ForegroundColor cyan
    write-host "===================================" -ForegroundColor cyan
    write-host "      $startdate"`n -ForegroundColor cyan
    write-host "Selected Function: [1] User Functions"`n -foregroundcolor cyan
    write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
    Write-Host "[i] Make sure you are using display names and not usernames"`n -foregroundcolor Yellow
    write-host "User Validation: " -nonewline; Write-Host "FAIL" -ForegroundColor Red; write-host "Cannot find user '$su' on $DC"`n
    Write-Host ""
    Pause
    . .\SU.ps1
}


# If input user is valid, continue to Selected User Functions page
Clear-Host
write-host "===================================" -ForegroundColor cyan
write-host "      ADPS Menu - Select User" -ForegroundColor cyan
write-host "===================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n
. .\SUF.ps1