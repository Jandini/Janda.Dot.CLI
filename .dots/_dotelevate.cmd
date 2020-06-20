@echo off

if "%~1" equ "" goto :eof
setlocal enableextensions

cd /d "%~dp0"
net session 2> nul 1> nul

if %ERRORLEVEL% neq 0 echo Elevating privileges... && goto elevate
goto exit

:elevate
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Start-Process -Wait -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0%~1\" %*' -Verb runAs"
exit /b 1

:exit
exit /b 0


