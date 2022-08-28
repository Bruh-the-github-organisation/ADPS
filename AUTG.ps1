Clear-Host
write-host "=========================================" -ForegroundColor cyan
write-host "      ADPS Menu - Add User to Group" -ForegroundColor cyan
write-host "=========================================" -ForegroundColor cyan
write-host "          $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / Add User to Group"`n -foregroundcolor cyan
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
    write-host "Add $dispname to $group (y/N)" -nonewline
    
    $AUTGConfirm = Read-Host " "
    if ($AUTGConfirm -eq 'y'){
        # Adds user to specified group
        try {
        add-adgroupmember -Identity $group -Members $uname
        }catch{
            write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
            Write-Host "`nAn error occured - $dispname was not added to $group`n" -ForegroundColor red
            Pause
            . .\SUF.ps1
        }
        # Logs the action to the audit file
        write-output "$thedate | Added $dispname ($uname) to $group | Changed by $currentuser" | Out-File C:\temp\Audit.txt -append
        write-host ""
        write-host "Added $dispname to $group"`n -foregroundcolor green
        pause
        . .\suf.ps1
    }
}else{
    # If group doesn't exist, show error
    Clear-Host
    write-host "=========================================" -ForegroundColor cyan
    write-host "      ADPS Menu - Add User to Group" -ForegroundColor cyan
    write-host "=========================================" -ForegroundColor cyan
    write-host "          $startdate"`n -ForegroundColor cyan
    write-host "Selected Function: [1] User Functions / Add User to Group"`n -foregroundcolor cyan
    write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
    Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
    
    
    # Pause the script, prompting the user to press enter to continue
    pause
    . .\AUTG.ps1
}