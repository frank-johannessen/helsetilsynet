param 
( 
	[string]$DeploymentPath = "D:\Helsetilsynet.InternetTest\web",
	[string]$BackupRoot = "D:\Helsetilsynet.InternetTest\backup",
	[string]$ConfigurationName = "Test",
	[string]$IISSiteName = "Helsetilsynet.InternetTest",
	[string]$IISApplicationName = "Helsetilsynet.InternetTest",
	[string[]]$AddAccessToFolders = @("www.helsetilsynet.no\Templates\Avenir\Scripts\", "www.helsetilsynet.no\Templates\Avenir\Styles\"),
	[string[]]$WorkerUsers = @("IUSR", "HTS-EPI01\IIS_IUSRS")
)

write "Running for configuration '$ConfigurationName' with DeploymentPath: '$DeploymentPath', BackupRoot: '$BackupRoot', IISSiteName: '$IISSiteName', IISApplicationName: '$IISApplicationName'"

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
$WebSites = Get-Website | where {$_.Name -eq $IISSiteName}
write "Websites: " $WebSites | Format-Table -AutoSize
write "Stoping websites..."  
$WebSites | select -Property "Name" | Stop-Website

$WebAppPools=Get-ChildItem iis:\apppools | select Name | ? {$_} | where {$_.Name -eq $IISApplicationName}
write "App Pools: " $WebAppPools | Format-Table -AutoSize
write "Stoping application pools..."  
$WebAppPools | Stop-WebAppPool


#----------------------------------------------------------------------------------
#CREATE BACKUP
if ([string]::IsNullOrEmpty($BackupRoot)){$BackupRoot = $CurrentDirectory}

$BackupName = [String]::Format("Backup_{0:yyyyMMdd_HHmmss}",[DateTime]::Now)
$BackupFilePath = [IO.Path]::Combine($BackupRoot,$BackupName + ".zip");

ZipDirectory $DeploymentPath $BackupFilePath


#----------------------------------------------------------------------------------
#REMOVE DESTINATION FILES AND FOLDERS
#waiting to release handles to all files before removing
[System.Threading.Thread]::Sleep(5000)

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
		try{
		Remove-Item -Path $FoldersToRemove -Recurse
		}
		catch [System.Exception]
		{
		write "Cannot delete folder " + $FoldersToRemove;
		return;
		}
	}
}

#----------------------------------------------------------------------------------
#COPY NEW FILES
#waiting to release handles to all files before copying
[System.Threading.Thread]::Sleep(5000)
write "Copying new files from '$WebPackageDirectory' to '$DeploymentPath'..."
[IO.Path]::Combine($WebPackageDirectory,"*") | Copy-Item -Destination $DeploymentPath -Recurse -Force

#----------------------------------------------------------------------------------
#APPLY CONFIGURATION CHANGES
$ConfigurationDirectory= [IO.Path]::Combine($PackageRootDirectory, [IO.Path]::Combine("config", $ConfigurationName))
write "Applying configuration changes from '$ConfigurationDirectory' to '$DeploymentPath'..."
[IO.Path]::Combine($ConfigurationDirectory ,"*") | Copy-Item -Destination  $DeploymentPath -Recurse -Force

#----------------------------------------------------------------------------------
#ADD PERMISSIONS TO READ/WRITE FOLDERS FOR WORKER USER:
foreach ($folder in $AddAccessToFolders) {
	$path = [IO.Path]::Combine($DeploymentPath, $folder);
	write "Adding access rights for folder: " + $path + " for the following users:"
	
	foreach($workerUser in $workerUsers) {
		$acl = Get-Acl $path
		write $workerUser
		
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$workerUser", "ReadData", "ContainerInherit, ObjectInherit", "None", "Allow")
		$acl.AddAccessRule($rule)
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$workerUser", "CreateFiles", "ContainerInherit, ObjectInherit", "None", "Allow")
		$acl.AddAccessRule($rule)
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$workerUser", "AppendData", "ContainerInherit, ObjectInherit", "None", "Allow")
		$acl.AddAccessRule($rule)
		$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$workerUser", "Modify", "ContainerInherit, ObjectInherit", "None", "Allow")
		$acl.AddAccessRule($rule)
		Set-Acl $path $acl
	}	
}

#----------------------------------------------------------------------------------
#START IIS SITE
write "Starting websites..."  
$WebSites | select -Property "Name" | Start-Website

#write "Starting application pools..."  
$WebAppPools | Start-WebAppPool

write "Finished"