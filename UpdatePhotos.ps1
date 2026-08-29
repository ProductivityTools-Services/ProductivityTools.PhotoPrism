$LogFile = "d:\log_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
#Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force

function Write-Log {
    param([string]$Message)
    "$((Get-Date -Format 'HH:mm:ss')) - $Message" | Out-File -FilePath $LogFile -Append
}
 #Write-Log -Message "start"
Write-Host "Start improved"
$SourceDirectory="f:\Prism\PrismPhoto\"
$DestinationDirectory="\\192.168.0.41\Prism\PrismPhoto\"

cd $SourceDirectory
Remove-PrefixFromDirectoryName
cd $DestinationDirectory
Remove-PrefixFromDirectoryName

Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 
#Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT /mt /NFL

Install-Module ProductivityTools.DirectoryReverseOrder  -Scope CurrentUser -Force -AcceptLicense

cd $SourceDirectory
Set-DirectoryInReverseOrder

cd $DestinationDirectory
Set-DirectoryInReverseOrder
Write-Host "End"
 #Write-Log -Message "end"

Write-Host "Update trash"
$SourceDirectory="f:\Prism\PrismTrash\"
$DestinationDirectory="e:\.backup.pt.Prism\PrismTrash\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 

$SourceDirectory="f:\Prism\OtherPhotos\"
$DestinationDirectory="e:\.backup.pt.Prism\OtherPhotos\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 

$SourceDirectory="f:\Prism\RodziceDrop\"
$DestinationDirectory="e:\.backup.pt.Prism\RodziceDrop\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT 


