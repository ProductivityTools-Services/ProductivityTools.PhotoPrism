$LogFile = "d:\log_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
#Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force

function Write-Log {
    param([string]$Message)
    "$((Get-Date -Format 'HH:mm:ss')) - $Message" | Out-File -FilePath $LogFile -Append
}
 #Write-Log -Message "start"
Write-Host "Start improved"
$SourceDirectory="e:\Prism\PrismPhoto\"
$DestinationDirectory="\\192.168.0.41\Prism\PrismPhoto\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 
#Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT /mt /NFL

Install-Module ProductivityTools.DirectoryReverseOrder  -Scope CurrentUser -Force -AcceptLicense
cd $SourceDirectory
Remove-PrefixFromDirectoryName
Set-DirectoryInReverseOrder
cd $DestinationDirectory
Remove-PrefixFromDirectoryName
Set-DirectoryInReverseOrder
Write-Host "End"
 #Write-Log -Message "end"

Write-Host "Update trash"
$SourceDirectory="e:\Prism\PrismTrash\"
$DestinationDirectory="f:\.backup.pt.Prism\PrismTrash\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 

$SourceDirectory="e:\Prism\OtherPhotos\"
$DestinationDirectory="f:\.backup.pt.Prism\OtherPhotos\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 

$SourceDirectory="e:\Prism\RodziceDrop\"
$DestinationDirectory="f:\.backup.pt.Prism\RodziceDrop\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 


