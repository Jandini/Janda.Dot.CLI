@echo off

setlocal enableextensions
cd /d "%~dp0"
net session 2> nul 1> nul

if %ERRORLEVEL% neq 0 echo Elevating privileges... && goto elevate
goto exit

:elevate
mshta "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%1.cmd', '', '', 'runas', 1);close();"
exit /b 1

:exit
exit /b 0


