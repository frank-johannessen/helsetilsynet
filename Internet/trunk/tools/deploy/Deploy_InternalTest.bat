echo "not prepared. auto deploy from build server"
::pushd %~dp0
::powershell -command "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser}"
::powershell ".\tools\deploy.ps1 -DeploymentPath 'd:\Inetpub\wwwroot\DNK' -BackupRoot 'd:\Inetpub\wwwroot\DNK_backup' -ConfigurationName 'Test'"
pause