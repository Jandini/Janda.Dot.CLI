@echo off
cd /d "%~dp0" & call _elevate.cmd %~nx0 %* > nul
if %ERRORLEVEL% equ 1 exit /b

call :install_choco
if "%2" equ "" goto :skip_check

call :check_prerequisites
if %ERRORLEVEL% equ 0 goto :eof

:skip_check
call :install_prerequisite "gitversion.portable --pre"
call :install_prerequisite "nuget.commandline"
call :install_prerequisite "7zip.install" 
call :install_prerequisite "dotnetcore"
call :install_prerequisite "git.install" 
call :install_prerequisite "jq" 
call :install_prerequisite "curl" 
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
choco install %~1 %~2
if %ERRORLEVEL% neq 0 title Installation failed&pause&exit
goto :eof 


:check_prerequisites
title Checking prerequisites...

nuget 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

7z 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

git --version 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

jq --help 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

curl --help 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

where gitversion 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

grep --help 1>2>nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

title  
goto :eof


