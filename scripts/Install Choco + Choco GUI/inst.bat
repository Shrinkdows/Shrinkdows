@echo off
powershell -ep bypass -c Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo | set /p dummy="Refreshing environment variables from registry for cmd.exe. Please wait..."
call refreshenv.cmd
choco install chocolateygui -y