@echo off

set DOT_PREREQUISITES=7z nuget git jq curl gitversion dotnetcore
set DOT_PREREQUISITES_CHOCOS="7zip.install" "nuget.commandline" "git.install" "git" "jq" "gitversion.portable --pre" "dotnetcore"


if "%~1" neq "check" goto :skip_check
call :check_prerequisites
exit /b %ERRORLEVEL% 

:skip_check

cd /d "%~dp0" & call _elevate.cmd %~nx0 %* > nul
if %ERRORLEVEL% equ 1 exit /b

call :install_choco
call :install_prerequisites
goto :eof



:install_prerequisites
for %%p in (%DOT_PREREQUISITES_CHOCOS%) do call :install_prerequisite %%p
goto :eof

:check_prerequisites
for %%p in (%DOT_PREREQUISITES%) do call :check_prerequisite %%p
goto :eof


:install_choco
title Checking choco...
choco -v 1>2>nul || goto :install
goto :configure
:install
title Installing choco...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:configure
choco feature enable -n allowGlobalConfirmation > nul
choco feature enable -n exitOnRebootDetected > nul
goto :eof


:install_prerequisite
title Choco is installing "%~1"...
choco install %~1
if %ERRORLEVEL% neq 0 title Installation failed&pause&exit
goto :eof 

:check_prerequisite
where %~1 >nul 2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof


