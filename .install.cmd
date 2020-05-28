@echo off

echo Checking prerequisites...
call .prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
rem Run 
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Start-Process -Wait -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0\_prerequisites.cmd\"' -Verb runAs"
 
:build
call .pack

echo Installation complete
goto :eof

