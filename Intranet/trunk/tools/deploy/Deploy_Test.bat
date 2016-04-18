powershell -command "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser}"
powershell ".\tools\deploy.ps1 -DeploymentPath 'C:\Deploy\Helsetilsynet.Intranet' -BackupRoot 'C:\Backup\Helsetilsynet.Intranet_backup' -ConfigurationName 'test' -SiteName 'Helsetilsynet.Intranet' -AppPoolName 'Helsetilsynet.IntranetAppPool'"
copy ".\web\Licenses\Test\*.config" "C:\Deploy\Helsetilsynet.Intranet" /Y
pause