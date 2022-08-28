Clear-Host
write-host "==============================================" -ForegroundColor cyan
write-host "      ADPS Menu - Remove User from Group" -ForegroundColor cyan
write-host "==============================================" -ForegroundColor cyan
write-host "            $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / Remove User from Group"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
# Prompts the user to enter the group name
$group = read-host "Enter group "
# If user inputs 'exit', go back to previous page
if ($group -eq 'exit'){
    . .\suf.ps1

}
# Performs a lookup of the group to check if it's valid, if yes continue
if (dsquery group -name $group){
    write-host ""
    # Ask the user to confirm the action
    write-host "Remove $dispname from $group (y/N)" -nonewline
    
    $RUTGConfirm = Read-Host " "
    if ($RUTGConfirm -eq 'y'){
        # Removes user from specified group
        try {
        remove-adgroupmember -identity $group -Members $uname -Confirm:$false
        }catch{
            write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
            Write-Host "`nAn error occured - $dispname was not removed from $group`n" -ForegroundColor red
            Pause
            . .\SUF.ps1
        }
        # Logs the action to the audit file
        write-output "$thedate | Removed $dispname ($uname) from $group | Changed by $currentuser" | Out-File C:\temp\Audit.txt -append
        write-host ""
        write-host "Removed $dispname from $group"`n -foregroundcolor green
        pause
        . .\suf.ps1
    }
}else{
    # If group doesn't exist, show error
    Clear-Host
    write-host "==============================================" -ForegroundColor cyan
    write-host "      ADPS Menu - Remove User from Group" -ForegroundColor cyan
    write-host "==============================================" -ForegroundColor cyan
    write-host "            $startdate"`n -ForegroundColor cyan
    write-host "Selected Function: [1] User Functions / Remove User from Group"`n -foregroundcolor cyan
    write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
    Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
    write-host "Group Validation: " -nonewline; write-host "FAIL" -ForegroundColor Red
    Write-Host "Cannot find $group on $dc"
    # Pause the script, prompting the user to press enter to continue
    pause
}