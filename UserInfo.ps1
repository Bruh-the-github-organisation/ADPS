# Setting variables for use when displaying information, also getting the user info
$UIName = Get-ADUser -Identity $uname | Select-Object -ExpandProperty name
$UIUsername = Get-ADUser -Identity $uname | Select-Object -ExpandProperty samaccountname
$UIEmailAddress = Get-ADUser -Identity $uname -Properties mail | Select-Object -ExpandProperty mail
$UIJobTitle = Get-ADUser -Identity $uname -property title | Select-Object -ExpandProperty title
$UIDepartment = Get-ADUser -Identity $uname -property department | Select-Object -ExpandProperty department
$UIEmployeeID = Get-ADUser -Identity $uname -Properties employeeid | Select-Object -ExpandProperty employeeid
$UIManager = (get-aduser (get-aduser $uname -Properties manager -ErrorAction SilentlyContinue).manager).name
$UIManagerEmailAddress = (Get-ADUser (Get-ADUser $uname -Properties manager -ErrorAction SilentlyContinue).manager -properties mail).mail
$UILockedOut = Get-ADUser -Identity $uname -property lockedout | Select-Object -ExpandProperty lockedout
$UIOU = Get-ADUser -Identity $uname -property canonicalname | Select-Object -ExpandProperty canonicalname
$UIEnabled = Get-ADUser -Identity $uname -property enabled | Select-Object -ExpandProperty enabled
$UIExpired = Get-ADUser -Identity $uname -property accountexpirationdate | Select-Object -ExpandProperty accountexpirationdate
$UILastLogon = Get-ADUser -Identity $uname -Properties "LastLogonDate" | Select-Object -ExpandProperty LastLogonDate
$UILastModified = get-aduser -Identity $uname -property whenChanged | Select-Object -expandproperty whenChanged

Clear-Host
write-host "========================================" -ForegroundColor cyan
write-host "      ADPS Menu - User Information" -ForegroundColor cyan
write-host "========================================" -ForegroundColor cyan
write-host "      $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / User Information"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan



# Displaying the info using the above variables
Write-Host "Name: " -ForegroundColor cyan -NoNewline; write-host "$UIName"
Write-Host "Username: " -ForegroundColor cyan -NoNewline; write-host "$UIUsername"

write-host "Email Address: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIEmailAddress){write-host "Unable to retrieve" -ForegroundColor red}
else{write-host "$UIEmailAddress"}

if ($UIEnabled -eq 'true'){write-host "Status: " -ForegroundColor cyan -NoNewline; write-host "Enabled" -ForegroundColor Green -NoNewline; write-host " | " -NoNewline}
else{write-host "Status: " -ForegroundColor cyan -NoNewline; write-host "Disabled" -ForegroundColor red -NoNewline; write-host " | " -NoNewline}
if ($UILockedOut -eq 'true'){write-host "Locked" -ForegroundColor red}
else{write-host "Unlocked" -ForegroundColor Green}

write-host "Job Title: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIJobTitle){write-host "Unable to retrieve" -ForegroundColor Red}
else{write-host "$UIJobTitle"}

write-host "Department: " -ForegroundColor cyan -NoNewline
if($null -eq $UIDepartment){write-host "Unable to retrieve" -ForegroundColor Red}
else{write-host "$UIDepartment"}

write-host "Manager: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIManager){write-host "Unable to retrieve" -ForegroundColor Red}
else{write-host "$UIManager ($UIManagerEmailAddress)"}

write-host "Employee ID: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIEmployeeID){write-host "Unable to retrieve" -ForegroundColor Red}
else{write-host "$UIEmployeeID"}

write-host "Organizational Unit: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIOU){write-host "Unable to retrieve" -ForegroundColor Red}
else{write-host "$UIOU"}

write-host "Expiry date: " -ForegroundColor cyan -NoNewline
if ($null -eq $UIExpired){write-host "Never Expires"}
else{Write-host "$UIExpired"}

write-host "Last Logon: " -ForegroundColor cyan -NoNewline
if($null -eq $UILastLogon){Write-host "Never"}
else{write-host "$UILastlogon"}

write-host "Last Modified: " -ForegroundColor cyan -NoNewline
if ($null -eq $UILastModified){write-host "Never"`n}
else{write-host "$UILastModified"`n}
pause
#write-output "$thedate | Looked up user information for $dispname ($uname) | Performed by $currentuser" | Out-File C:\temp\Audit.txt -append
Clear-Variable UIName
Clear-Variable UIUsername
Clear-Variable UIEmailAddress
Clear-Variable UIJobTitle
Clear-Variable UIDepartment
Clear-Variable UIEmployeeID
Clear-Variable UIManager
Clear-Variable UIManagerEmailAddress
Clear-Variable UILockedOut
Clear-Variable UIOU
Clear-Variable UIEnabled
Clear-Variable UILastLogon
. .\SUF.ps1