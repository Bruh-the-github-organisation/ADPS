Clear-Host
write-host "===============================" -ForegroundColor cyan
write-host "      ADPS Menu - Starter" -ForegroundColor cyan
write-host "===============================" -ForegroundColor cyan
write-host "     $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions / [3] S/L/T Menu / [1] Starter"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
# Prompt for model user and get relevant info
$modeluser = read-host -Prompt "Model User"
write-host "`nLooking up $modeluser..." -ForegroundColor Yellow
$DC = get-addomaincontroller | Select-Object -ExpandProperty hostname
if (dsquery user -name $modeluser){
try {
    $ModelUserSAM = get-aduser -filter {displayname -like $modeluser} | Select-Object -expandproperty samaccountname
    write-host "Retrived information for $modeluser"`n -ForegroundColor green
    }

catch {
        clear-hosts
        write-host "===============================" -ForegroundColor cyan
        write-host "      ADPS Menu - Starter" -ForegroundColor cyan
        write-host "===============================" -ForegroundColor cyan
        write-host "     $startdate"`n -ForegroundColor cyan
        write-host "Selected Function: [1] User Functions / [3] S/L/T Menu / [1] Starter"`n -foregroundcolor cyan
        write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
        write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
        Write-Host "`nAn error occured - unable to retreive information for $modeluser`n" -ForegroundColor red
    }
} else {
        clear-host
        write-host "===============================" -ForegroundColor cyan
        write-host "      ADPS Menu - Starter" -ForegroundColor cyan
        write-host "===============================" -ForegroundColor cyan
        write-host "     $startdate"`n -ForegroundColor cyan
        write-host "Selected Function: [1] User Functions / [3] S/L/T Menu / [1] Starter"`n -foregroundcolor cyan
        write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
        Write-Host "[i] Make sure you are using display names and not usernames"`n -foregroundcolor Yellow
        write-host "User Validation: " -nonewline; Write-Host "FAIL" -ForegroundColor Red; write-host "Cannot find user '$modeluser' on $DC"`n
        Write-Host ""
        Pause
        . .\sltstarter.ps1
        }

# Get model user ou and remove 'CN=First Last,' from the output
$NSOUUT= Get-ADUser -identity $ModelUserSAM -property distinguishedname | Select-Object -ExpandProperty DistinguishedName
$NSOUCN = $NSOUUT -replace ("CN=","")
$NSOUC = $NSOUCN -replace ("$modeluser","")
$NSOU = $NSOUC.Trim(","," ")


# Get new starter details and place into variables
Write-host "Enter details below for new starter" -ForegroundColor Yellow

$NSFirstName = read-host "First name"
$NSLastName = read-host "Last name"
$NSName = "$NSFirstName" + " " + "$NSLastName"
$NSSAM = Read-Host "Username"
$NSSAMLength = $NSSAM.Length
if ($NSSAM.Length -eq 8){}
else {
    write-host "Username is invalid - $NSSAMLength characters" -ForegroundColor Red
    $NSSAM = Read-Host "Username"
}
write-host "Performing lookup for username..." -foregroundcolor Yellow
$NSSAMCheck = get-aduser -filter {samaccountname -like "$NSSAM"} | Select-Object -ExpandProperty samaccountname
if ($null -eq $NSSAMCheck){
    write-host "Username is not taken" -ForegroundColor Green
} else {
    write-host "Username is taken" -ForegroundColor Red
    $NSSAM = Read-Host "Username"
}
$NSEmailAddress = read-host "Email address"
write-host "Performing lookup for email address..." -foregroundcolor Yellow
$NSEmailCheck = get-aduser -filter {emailaddress -like "$NSEmailAddress"}
if ($null -eq $NSEmailCheck){
    write-host "Email address is not taken" -ForegroundColor Green
} else {
    write-host "Email address is taken" -ForegroundColor Red
    $NSEmailAddress = read-host "Email address"
}
$NSUserThirdParty = read-host "[1] contractor / [2] consultant / [N] neither? (1/2/N)"
$NSOffice = read-host "[R]emote or [O]ffice based"
$NSDescription = read-host "Account description (Enter 'n' if N/A)"
#$NSPhone = read-host "Phone number (Enter 'n' if not known)"
$NSEmployeeID = read-host "Employee ID (Enter 'n' if not known)"
$NSTitle = read-host "Job title"
$NSDepartment = read-host "Department"
$NSManager = read-host "Manager (username)"
$NSITOpsDev = read-host "Developer or IT Ops [GitLab] (y/N)"


write-host "`n[i] A notepad file will open, copy and paste all AD groups the new starter needs (basic AD account groups are included by default), save and close"`n -ForegroundColor yellow
pause

New-Item "C:\temp\Groups-Add.txt" | Out-Null
notepad.exe C:\temp\Groups-Add.txt

read-host -Prompt "`nPress any key once groups have been added to the file and saved..."

# Predefine password for user
$secpasswd = ConvertTo-SecureString -String "Monday98741!" -AsPlainText -Force

write-host "    Creating AD Account    "`n -ForegroundColor Black -BackgroundColor Yellow
try {
New-ADUser `
    -Name "$NSFirstName $NSLastName" `
    -GivenName "$NSFirstName" `
    -Surname "$NSLastName" `
    -SamAccountName "$NSSAM" `
    -AccountPassword $secpasswd `
    -ChangePasswordAtLogon $False `
    -Company "Hargreaves Lansdown" `
    -Title "$NSTitle" `
    -Department "$NSDepartment" `
    -DisplayName "$NSFirstName $NSLastName" `
    -Enabled $True `
    -Path "$NSOU"
write-host "Created AD account for $NSName"`n -ForegroundColor Green
} catch {
    write-host "`n          ERROR!          " -ForegroundColor Black -BackgroundColor Red
    Write-Host "`nAn error occured - unable to create account for $NSName"`n -ForegroundColor red
    pause
    Get-Variable -Exclude PWD,*Preference | Remove-Variable -EA 0
    . .\SLTF.ps1
}

write-host "    Setting account attributes    "`n -ForegroundColor Black -BackgroundColor Yellow


# Set attributes based on the above variables

try {
    Set-ADUser -Identity $NSSAM -Add @{extensionAttribute1="$NSSAM"}
    
} catch {
    write-host "Error setting extensionAttribute1"`n -ForegroundColor Red
}

try {
    set-aduser -identity $NSSAM -UserPrincipalName "$NSFirstName.$NSLastName@hl.co.uk"
    
}
catch {
    write-host "Error setting UPN for $NSName" -foregroundcolor Red
}

try{
set-aduser -identity $NSSAM -EmailAddress "$NSEmailAddress"

} Catch {
    write-host "Error setting email address" -ForegroundColor Red
}
<#
if ($NSPhone -contains 'n'){
    Write-Host "No phone number set" -ForegroundColor Yellow
    $NSTemplatePhone = "N/A"
}else{
    try {
    set-aduser -identity "$NSSAM" -HomePhone "$NSPhone"
    write-host "Set phone number for $NSName to $NSPhone" -ForegroundColor Green
    } catch {
        Write-Host "Error setting phone number" -foregroundcolor Red
    }
}
#>
if ($NSUserThirdParty -eq 'n'){
    $NSTemplateThirdParty = "N/A"
}elseif ($NSUserThirdParty -eq '1' -or '2'){
    try {
        Set-ADUser -Identity $NSSAM -Add @{EmployeeType="Third Party"}
        $NSTemplateThirdParty = "Done"
    } catch {
        Write-Host "Error setting employeeType" -foregroundcolor Red
    }
} else {Write-Host "Skipping third party - invalid input type" -ForegroundColor Yellow}

if($NSEmployeeID -eq 'n'){

}else {
    try{
        Set-ADUser -Identity $NSSAM -EmployeeID "$NSEmployeeID"
    } catch {
        Write-Host "Error setting employeeID" -foregroundcolor Red
    }
}

try {
    Set-ADUser -Identity $NSSAM -Manager "$NSManager"
} catch {
    Write-Host "Error setting manager" -foregroundcolor Red
}

if ($NSDescription -eq 'n'){
} else{
    try {
        Set-ADUser -Identity $NSSAM -Description "$NSDescription"
    }
    catch {
        write-host "Error setting description for $NSName" -ForegroundColor Red
    }
}

if ($NSOffice -eq 'O' -or 'o'){
    try {
        Set-ADUser -Identity $NSSAM -Office "Harbourside 1"
    }
    catch {
        write-host "Error setting office for $NSName" -ForegroundColor Red
    }
}else {
    try {
        Set-ADUser -Identity $NSSAM -Office "Remote Worker"
    }
    catch {
        write-host "Error setting office for $NSName" -ForegroundColor Red
    }
}



$NSExpirationDate = Get-Date -date $(Get-Date).AddDays(15) -Format (Get-Culture).DateTimeFormat.ShortDatePattern

try{
    Set-ADAccountExpiration -identity $NSSAM -DateTime "$NSExpirationDate"

}
catch {
    write-host "Error setting account expiration date for $NSName" -foregroundcolor Red
}

$NSGroups= Get-Content "C:\temp\Groups-Add.txt"

write-host "    Adding to groups    "`n -ForegroundColor Black -BackgroundColor Yellow

ForEach ($Group In $NSGroups)
{
    try{
    Add-ADGroupMember -Identity $Group -Members $NSSAM #-WhatIf
    }catch{
    write-host "`n$NSName was not added to $Group" -ForegroundColor Red
    }
}

try {
    Add-ADGroupMember -Identity "Proxy Websense Users" -Members $NSSAM
}
catch {
    write-host "$NSName was not added to Proxy Websense Users" -ForegroundColor Red
}


try {
    Add-ADGroupMember -Identity "Self Service Password Reset" -Members $NSSAM
}
catch {
    write-host "$NSName was not added to Self Service Password Reset" -ForegroundColor Red
}


try {
    Add-ADGroupMember -Identity "MetaCompliance Users" -Members $NSSAM
}
catch {
    write-host "$NSName was not added to MetaCompliance Users" -ForegroundColor Red
}


try {
    Add-ADGroupMember -Identity "Remote Access Users" -Members $NSSAM
}
catch {
    write-host "$NSName was not added to Remote Access Users" -ForegroundColor Red
}


try {
    Add-ADGroupMember -Identity "Zoom Basic Users" -Members $NSSAM
    }
catch {
    write-host "$NSName was not added to Zoom Basic Users" -ForegroundColor Red
}

if ($NSITOpsDev -eq 'y'){
    try {
        Add-ADGroupMember -Identity "GitLab IT Users" -Members $NSSAM
        $NSITOpsDevTemplate -eq "- Done"
        
    }
    catch {
        write-host "$NSName was not added to GitLab IT Users" -ForegroundColor Red
        
    }
} else {$NSITOpsDevTemplate -eq "- N/A"}

write-host "    Creating template    " -ForegroundColor Black -BackgroundColor Yellow

$GroupsTemplate = Get-Content "C:\Temp\Groups-Add.txt"

Set-Content C:\temp\Starter-Template.txt @"
Starter - AD Processing Only





New Starter Process - Mark as DONE when complete (In BOLD TYPE)
https://confluence.hargreaveslansdown.co.uk/display/SERVD/Starter+Process
Check the above PI's have been completed and raise the following as necessary:
If this is an IT user that requires 'Privileged access' as per IT Access Policy, send auth to Head of IT Operations
Raise REQ to Unix Support if a Service Desk starter and access to Sybase (Spidermail SSH) is required: https://confluence.hargreaveslansdown.co.uk/display/IO/Sybase+-+Servicedesk+user+accounts
If user is an IT Starter, please check whether any additional REQ's need to be raised (eg if Unix starter, REQ to Unix)





1)    Create AD account (ensure the username is eight characters long) - Done
                Username of account: $NSSAM
2)    If the user is a third party (Consultant/Contractor), please add "Third Party" into the Employee Type field within Attribute Editor within AD - $NSTemplateThirdParty
3)    Check Attribute Editor "extensionAttribute1" states the users user ID and not any other user ID - Done
4)    Add the telephone ext to Attribute Editor "extensionAttribute3" if applicable or clear this field if no telephone ext required - N/A
5)    Check the Organisation Tab and update / change the Job Title / Department and Line Manager (Copy and Paste) - Done
6)    Add the Basic Access AD groups needed for the role (You can use this Powershell to obtain the list T:\IT LIBRARY\Infrastructure\Service Desk\Team Tools\Powershell Scripts\Get-MemberOf). List the AD groups added below:

Domain Users
Proxy Websense Users
Self Service Password Reset
MetaCompliance Users
Remote Access Users
Zoom Basic Users
"@

$GroupsAdd = get-content -Path "C:\temp\Groups-Add.txt"
write-output $GroupsAdd | Out-File C:\temp\Starter-Template.txt -Append

write-output @"

7)    Ensure the email address is populated into the AD account General tab field - Done
8)    Set the AD account to expire 2 weeks after the allotted start date, If a Contractor/Consultant add the contract end date - Done
9)    Create P and S drives and add modify permission to the S drive for the user - 
10)    If IT user (Developer or IT Ops) add to 'GitLab IT Users - $NSITOpsDevTemplate
11)    Check other system access - 
"@  | Out-File C:\temp\Starter-Template.txt -Append

notepad.exe C:\temp\Starter-Template.txt

remove-item -Path "C:\temp\Groups-Add.txt"
write-host `n"You will need to create P & S drives for $NSSAM"`n -ForegroundColor Yellow

write-host "=== Part 1 complete ==="`n -ForegroundColor Green
$P2Continue = read-host "Do you want to create the users mailbox [WORK IN PROGRESS] (y/N)"
if ($P2Continue -eq 'y'){
    # THE BELOW NEEDS TO RUN IN EXCHANGE MANAGEMENT SHELL
    Enable-RemoteMailbox -identity "$NSName" -remoteroutingaddress "$NSFirstName.$NSLastName@hargreaveslansdown.mail.onmicrosoft.com"
    remove-item -Path "C:\temp\Starter-Template.txt"
} else {
    Pause
    remove-item -Path "C:\temp\Starter-Template.txt"
    . .\SLTF.ps1
}



Get-Variable -Exclude PWD,*Preference | Remove-Variable -EA 0