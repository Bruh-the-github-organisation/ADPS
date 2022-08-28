Clear-Host
write-host ""
write-host "STRIPE ATTRIBUTE NEEDS TO BE CHANGED" -foregroundcolor red
start-sleep 1
clear-host
Clear-Host
write-host ""
write-host "STRIPE ATTRIBUTE NEEDS TO BE CHANGED" -foregroundcolor white
start-sleep 1
clear-host
Clear-Host
write-host ""
write-host "STRIPE ATTRIBUTE NEEDS TO BE CHANGED" -foregroundcolor red
start-sleep 1


clear-host
write-host "=========================================" -ForegroundColor cyan
write-host "      ADPS Menu - Check User Access" -ForegroundColor cyan
write-host "=========================================" -ForegroundColor cyan
write-host "         $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions > [4] Check User Access"`n -foregroundcolor cyan
write-host "[i] This will check if users have access to AD based systems such as Miro, Stripe, Atlassian etc..."`n -ForegroundColor Cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor yellow


# Atlassian Cloud
$AtlassianCloud = Get-ADGroupMember -identity "Atlassian Cloud Users" | Select-Object -expandproperty samaccountname
$AtlassianCloudExternal = Get-ADGroupMember -identity "Atlassian Cloud External Access" | Select-Object -expandproperty samaccountname
$AtlassianCloudThirdParty = Get-ADGroupMember -identity "Atlassian Third Party Device" | Select-Object -expandproperty samaccountname
write-host "Atlassian Cloud: " -ForegroundColor Yellow -NoNewline

if ($AtlassianCloud -contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline; write-host " | Atlassian Cloud Users" -foregroundcolor yellow}
elseif ($AtlassianCloud -Contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline; write-host " | Atlassian Cloud Users" -foregroundcolor yellow}
elseif ($AtlassianCloudExternal -contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline; write-host " | Atlassian Cloud External Access" -foregroundcolor yellow}
elseif ($AtlassianCloudThirdParty -Contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline; write-host " | Atlassian Third Party Device" -foregroundcolor yellow}
else {write-host "No" -ForegroundColor Red}



# BitBucket
$BitBucket = Get-ADGroup -Filter {name -like "Bitbucket*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname

write-host "BitBucket: " -ForegroundColor Yellow -NoNewline

if ($BitBucket -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# NETREC Broker Focus
$NETRECBF = Get-ADGroupMember -identity "Network Resource - Broker Focus" | Select-Object -expandproperty samaccountname

write-host "Broker Focus (Network Resource): " -ForegroundColor Yellow -NoNewline

if ($NETRECBF -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


#Confluence (on-prem)
$ConfluenceOP = Get-ADGroup -Filter {name -like "Confluence*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname

write-host "Confluence (on-prem): " -ForegroundColor Yellow -NoNewline

if ($ConfluenceOP -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# GitLab
$GitLab = Get-ADGroup -Filter {name -like "GitLab*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname

write-host "GitLab: " -ForegroundColor Yellow -NoNewline

if ($GitLab -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# Miro
$Miro = Get-ADGroupMember -identity "Miro Users" | Select-Object -expandproperty samaccountname

write-host "Miro: " -ForegroundColor Yellow -NoNewline

if ($Miro -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# NETREC Spidermail
$NETRECSM = Get-ADGroupMember -identity "Network Resource - Spidermail" | Select-Object -expandproperty samaccountname

write-host "Spidermail (Network Resource): " -ForegroundColor Yellow -NoNewline

if ($NETRECSM -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# Stripe
$Stripe = Get-ADGroupMember -identity "Stripe Users" | Select-Object -expandproperty samaccountname
$StripeAccess = get-aduser -filter {samaccountname -like $uname} -properties * | Select-Object -ExpandProperty division

write-host "Stripe: " -ForegroundColor Yellow -NoNewline

if ($Stripe -notcontains $uname -and $null -ne $StripeAccess){Write-Host "WARN - NOT IN GROUP" -ForegroundColor Red -nonewline; write-host " | Access Level: $StripeAccess" -ForegroundColor Yellow}
else {if ($Stripe -contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline}
else {write-host "No" -ForegroundColor Red}
if ($null -ne $StripeAccess) {write-host " | Access Level: $StripeAccess" -foregroundcolor yellow}
else {}}

#write-host "Stripe: " -ForegroundColor Yellow -NoNewline

#if ($Stripe -contains $uname){Write-Host "Yes" -ForegroundColor Green -nonewline}
#else {write-host "No" -ForegroundColor Red}
#if ($null -ne $StripeAccess) {write-host " | Role: $StripeAccess" -foregroundcolor yellow}
#else {}



# VDI
$VDI = Get-ADGroup -Filter {name -like "VDI*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname

write-host "VDI: " -ForegroundColor Yellow -NoNewline

if ($VDI -contains $uname){Write-Host "Yes" -ForegroundColor Green}
else{write-host "No" -ForegroundColor Red}


# Twilio

write-host "Twilio: " -ForegroundColor Yellow -NoNewline

$Twilio = Get-ADGroupMember -Identity "Twilio Users" | Select-Object -ExpandProperty samaccountname
if ($Twilio -contains $user){write-host "Yes" -foregroundcolor green}
else{Write-Host "No" -ForegroundColor red}


# Verint

write-host "Verint: " -ForegroundColor yellow -NoNewline

$VerintAccess = Get-ADGroup -Identity "Verint Application Access" | get-adgroupmember | Select-Object -ExpandProperty samaccountname
if ($VerintAccess -contains $uname){write-host " Yes" -ForegroundColor Green}
else {Write-Host "No" -ForegroundColor Red}



#zoom pro
$ZoomPro = Get-ADGroup -Filter {name -like "Zoom Users*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname
$ZoomBasic = Get-ADGroup -Filter {name -like "Zoom Basic Users*"} | Get-ADGroupMember | Select-Object -expandproperty samaccountname

write-host "Zoom: " -ForegroundColor Yellow -NoNewline

if($ZoomPro -contains $uname){write-host "Yes" -ForegroundColor Green -NoNewline; Write-Host " | Access Level: Zoom Pro" -ForegroundColor Yellow}
elseif($ZoomBasic -contains $uname){write-host "Yes" -ForegroundColor Green -NoNewline; Write-Host " | Access Level: Zoom Basic" -ForegroundColor Yellow}
else{Write-host "No" -ForegroundColor Red}




Pause
. .\SUF.ps1