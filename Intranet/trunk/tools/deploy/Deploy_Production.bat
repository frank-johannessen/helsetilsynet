powershell -command "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser}"
powershell ".\tools\deploy.ps1 -DeploymentPath 'C:\EPiServer\Sites\Helsetilsynet.Intranet' -BackupRoot 'C:\Backup\Helsetilsynet.Intranet_backup' -ConfigurationName 'Production' -SiteName 'Helsetilsynet.Intranet' -AppPoolName 'Helsetilsynet.IntranetAppPool'"
copy ".\web\Licenses\Production\*.config" "C:\EPiServer\Sites\Helsetilsynet.Intranet\" /Y
pause