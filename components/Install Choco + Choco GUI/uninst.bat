@echo off
taskkill /f /im choco.exe
choco uninstall chocolateygui -y
powershell -ep bypass -file anticoco.ps1