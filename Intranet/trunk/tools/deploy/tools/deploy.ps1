param 
( 
	[string]$DeploymentPath = "C:\Deploy\Helsetilsynet.Intranet",
	[string]$BackupRoot = "C:\Backup\Helsetilsynet.Intranet_backup",
	[string]$ConfigurationName = "Test",
	[string]$SiteName = "Helsetilsynet.Intranet",
	[string]$AppPoolName = "Helsetilsynet.IntranetAppPool"
)

write "Running for configuration '$ConfigurationName' with DeploymentPath: '$DeploymentPath', BackupRoot: '$BackupRoot'"

#stop on error
$script:ErrorActionPreference = "Stop"
Import-Module WebAdministration


function Get-ScriptDirectory 
{ 
	$Invocation = (Get-Variable MyInvocation -Scope 1).Value 
	Split-Path $Invocation.MyCommand.Path 
}

$ScriptDirectory=Get-ScriptDirectory  
$PackageRootDirectory=[IO.Path]::GetFullPath([IO.Path]::Combine($ScriptDirectory,"..\"));

function ZipDirectory([string]$SourceDirectory, [string]$ZipFilePath)
{		
	write "Creating Zip archive of '$SourceDirectory' in '$ZipFilePath'..."
	$ZipFileDirectory = [IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($ZipFilePath))
	$SharpZipLibAssembly = [Reflection.Assembly]::LoadFile([IO.Path]::Combine($ScriptDirectory ,"ICSharpCode.SharpZipLib.dll"))
	$FastZip = new-object ICSharpCode.SharpZipLib.Zip.FastZip
	$FastZip.CreateZip($ZipFilePath, $SourceDirectory, $true, $null);	
}


 
 
#SETUP 

$WebPackageDirectory = [IO.Path]::Combine($PackageRootDirectory,"web")
[Environment]::CurrentDirectory =  $PackageRootDirectory

$CurrentDirectory = [Environment]::CurrentDirectory 


#----------------------------------------------------------------------------------
#STOP SITES IN IIS
$WebSites = Get-Website | where {$_.Name -match $SiteName}
write "Websites: " $WebSites | Format-Table -AutoSize
write "Stoping websites..."  
$WebSites | select -Property "Name" | Stop-Website

#$WebAppPools=Get-ChildItem iis:\apppools | select Name | ? {$_} | where {$_ -match $AppPoolName}
#write "App Pools: " $WebAppPools | Format-Table -AutoSize
#write "Stoping application pools..."  
#$WebAppPools | Stop-WebAppPool


#----------------------------------------------------------------------------------
#CREATE BACKUP
if ([string]::IsNullOrEmpty($BackupRoot)){$BackupRoot = $CurrentDirectory}

$BackupName = [String]::Format("Backup_{0:yyyyMMdd_HHmmss}",[DateTime]::Now)
$BackupFilePath = [IO.Path]::Combine($BackupRoot,$BackupName + ".zip");

ZipDirectory $DeploymentPath $BackupFilePath


#----------------------------------------------------------------------------------
#REMOVE DESTINATION FILES AND FOLDERS
#waiting to release handles to all files before removing
[System.Threading.Thread]::Sleep(2000)

$FoldersToRemove = "Templates","bin","Content","lang" | foreach{[IO.Path]::Combine($DeploymentPath , $_)} | where {Test-Path $_}
write "Deleting files ..."
$FoldersToRemove | Format-Table -AutoSize
if ($FoldersToRemove) { 
	try{
		Remove-Item -Path $FoldersToRemove -Recurse
	}
	catch [System.Exception]
	{
		write "Retrying delete files ..."
		[System.Threading.Thread]::Sleep(5000)
		$FoldersToRemove = $FoldersToRemove | where {Test-Path $_}
		Remove-Item -Path $FoldersToRemove -Recurse
	}
}

#----------------------------------------------------------------------------------
#COPY NEW FILES
write "Copying new files from '$WebPackageDirectory' to '$DeploymentPath'..."
[IO.Path]::Combine($WebPackageDirectory,"*") | Copy-Item -Destination $DeploymentPath -Recurse -Force

#----------------------------------------------------------------------------------
#APPLY CONFIGURATION CHANGES
$ConfigurationDirectory= [IO.Path]::Combine($PackageRootDirectory, [IO.Path]::Combine("config", $ConfigurationName))
write "Applying configuration changes from '$ConfigurationDirectory' to '$DeploymentPath'..."
[IO.Path]::Combine($ConfigurationDirectory ,"*") | Copy-Item -Destination  $DeploymentPath -Recurse -Force

#----------------------------------------------------------------------------------
#START IIS SITE
write "Starting websites..."  
$WebSites | select -Property "Name" | Start-Website

#write "Starting application pools..."  
#$WebAppPools | Start-WebAppPool

write "Finished"