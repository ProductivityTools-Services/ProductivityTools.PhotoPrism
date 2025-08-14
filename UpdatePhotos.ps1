$SourceDirectory="e:\Prism\PrismPhoto\"
$DestinationDirectory="\\192.168.0.41\Prism\PrismPhoto\"
Robocopy.exe $SourceDirectory $DestinationDirectory /MIR /DCOPY:T /e /copy:DAT /mt 

cd $SourceDirectory
Remove-PrefixFromDirectoryName
Set-DirectoryInReverseOrder
cd $DestinationDirectory
Remove-PrefixFromDirectoryName
Set-DirectoryInReverseOrder