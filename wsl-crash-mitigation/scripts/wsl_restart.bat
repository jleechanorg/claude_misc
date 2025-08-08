@echo off
echo Shutting down WSL...
wsl --shutdown
timeout /t 3 /nobreak > nul
echo Starting WSL...
wsl
echo WSL restarted successfully