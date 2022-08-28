$NSEmailAddress = read-host "Email address"
write-host "Performing lookup for email address..." -foregroundcolor Yellow
$NSEmailCheck = get-aduser -filter {emailaddress -like "$NSEmailAddress"}
if ($null -eq $NSEmailAddress){
    write-host "Email address is not taken" -ForegroundColor Green
} else {
    write-host "Email address is taken" -ForegroundColor Red
    $NSEmailAddress = read-host "Email address"
}