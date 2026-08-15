@echo off
rem Start PlayAural pointed at the Serrebi Radio Palace server.
rem Run this the first time. Afterwards PlayAural.exe remembers the setting,
rem so you can start the app normally if you prefer.
setlocal
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serrebi-setup.ps1"

rem Start the app even if the step above failed, so you are never left
rem without a way in.
start "" "%~dp0PlayAural.exe"

endlocal
