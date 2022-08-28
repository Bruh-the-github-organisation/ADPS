$NSSAM = Read-Host "Username"
$NSSAMLength = $NSSAM.Length
if ($NSSAM.Length -eq 8){}
else {
    write-host "Username is invalid - $NSSAMLength characters" -ForegroundColor Red
    $NSSAM = Read-Host "Username"
}
write-host "Performing lookup for username..." -foregroundcolor Yellow
$NSSAMCheck = get-aduser -filter {samaccountname -like "$NSSAM"}
if ($null -eq $NSSAM){
    write-host "Username is not taken" -ForegroundColor Green
} else {
    write-host "Username is taken" -ForegroundColor Red
    $NSSAM = Read-Host "Username"
}