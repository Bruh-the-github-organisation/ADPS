Clear-Host
write-host "===============================================" -ForegroundColor cyan
write-host "      ADPS Menu - Selected User Functions" -ForegroundColor cyan
write-host "===============================================" -ForegroundColor cyan
write-host "            $startdate"`n -ForegroundColor cyan
write-host "Selected Function: [1] User Functions"`n -foregroundcolor cyan
write-host "[i] To go back, type 'exit'"`n -foregroundcolor cyan
Write-Host "Selected User: $dispname ($uname)"`n -foregroundcolor cyan
Write-Host "[1] Add User to Group"
Write-Host "[2] Remove User from Group"
Write-Host "[3] User Information"
Write-Host "[4] Check User Access"
Write-Host "[5] Enable Account"
Write-Host "[6] Disable Account"
Write-Host "[7] Get User Groups"
Write-Host "[8] Get Members of Group"
Write-Host "[9] Check Expiration Date"`n
write-host "Enter a number" -NoNewline
$SUFChoice = read-host " "
# If user inputs '1' go to Add User to Group pages
if ($SUFChoice -eq '1'){
    . .\AUTG.ps1
# If user inputs '2' go to Remove User from Group page
}elseif ($SUFChoice -eq '2'){
    . .\RUTG.ps1
# If user inputs '3' go to User Information page
}elseif ($SUFChoice -eq '3'){
    . .\UserInfo.ps1
# If user inputs '2' go to Remove User from Group page
}elseif ($SUFChoice -eq '4'){
    . .\CUA.ps1

}elseif ($SUFChoice -eq '5'){
    . .\ENU.ps1

}elseif ($SUFChoice -eq '6'){
    . .\DBU.ps1

}elseif ($SUFChoice -eq '7'){
    . .\GUG.ps1

}elseif ($SUFChoice -eq '8'){
    . .\GMG.ps1

}elseif ($SUFChoice -eq '9'){
    . .\CED.ps1

# If user inputs 'exit', go back to previous page
}elseif ($SUFChoice -eq 'exit'){
    . .\UserF.ps1
}else{
    . .\SUF.ps1
}