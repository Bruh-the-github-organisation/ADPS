clear-host
# Checks if running as admin account
#$admincheck = $env:username
#if ($admincheck -contains "parox*"){
#}else{
#    . .\admerror.ps1
#    exit
#}
#write-host "ADM=$admincheck" -ForegroundColor Black -BackgroundColor Yellow
#console background colour to black
[console]::BackgroundColor = "black"
$startdate = Get-Date -Format "dddd MMMM dd yyyy"
# Import the AD module for PowerShell
Import-Module activedirectory
# Gets the current date and time, for use in logging actions
$thedate = Get-Date -Format "dd/MM/yyyy HH:mm:s"
# Gets the currently logged in user on this machine, for use in logging actions
$currentuser = Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty username -erroraction silentlycontinue
# Print the main menu selection
write-host "=================================" -ForegroundColor cyan
write-host "      ADPS Menu - Main Menu" -ForegroundColor cyan
write-host "=================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "[i] To quit this script at any time, press CTRL + C"`n -foregroundcolor cyan
write-Host "[i] To re-run this script if it exits, press the up arrow and enter, or if using PS ISE, press F5"`n -foregroundcolor cyan
write-host "[1]  User Functions"
write-host "[2]  Computer Functions"
write-host "[3]  S/L/T Menu"
write-host "[4]  Folder Permissions"
write-host "[5]  Local Admin Access"`n
# Checks to see if audit file exists, depending on result, show relevant text
If (Test-Path -Path "C:\temp\Audit.txt" ) {
    write-host "[0] View Audit Log | " -nonewline; write-host "Audit log exists"`n -ForegroundColor green
}else{
    write-host "[0] View Audit Log | " -nonewline; write-host "Audit log does not exist"`n -ForegroundColor red
}
write-host "Enter a number" -NoNewline
$mmchoice = read-host " "
# If user inputs '1', go to User Functions page
if ($mmchoice -eq '1'){
    Clear-Variable mmchoice
    . .\userf.ps1

}elseif($mmchoice -eq '2'){
    . .\adps-main.ps1

}elseif($mmchoice -eq '3'){
    . .\SLTF.ps1
# If user inputs '0', check to see if 'C:\Temp\Audit.txt' exists - if it does, open it
}elseif ($MMChoice -eq '0'){
    
    If (Test-Path -Path C:\temp\audit.txt ) {
        write-host ""
        write-host "Opening audit file" -foregroundcolor cyan
        $FileLocation = 'C:\temp\Audit.txt'
        Start-Process notepad $FileLocation
        start-sleep 2
        . .\adps-main.ps1
    }else{
        # If 'C:\Temp\Audit.txt' does not exist, show the below message
        write-host ""
        write-host "Audit file has not yet been created. This is an automatic process that happens when the first action is performed. The audit file will be saved to 'C:\Temp\Audit.txt'" -foregroundcolor yellow
        write-host ""
        pause
        . .\adps-main.ps1
    }
# If user inputs 'exit', quit
}elseif ($mmchoice -eq 'exit'){
    clear-variable group
    Clear-Variable DC
    Clear-Variable dispname
    Clear-Variable uname
    Clear-Variable SU
    Clear-Variable mmchoice
    Clear-Variable UserFChoice
    exit
# If user inputs '7' deny function and write to audit log
}elseif ($mmchoice -eq '7'){
    write-host "`nNot Allowed" -ForegroundColor Red
#    write-output "$thedate | Attempted Local administrator access - denied | Attempted by $currentuser" | Out-File C:\temp\Audit.txt -append
    Start-Sleep 2
    . .\adps-main.ps1
#    . .\LocalAdmin.ps1
}else{
    . .\adps-main.ps1

}