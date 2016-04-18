pushd %~dp0
powershell -command "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser}"
powershell ".\tools\deploy.ps1 -DeploymentPath 'c:\Inetpub${Model.Solution.Name}' -BackupRoot 'c:\Inetpub${Model.Solution.Name}_backup' -ConfigurationName 'Staging'"
pause