@echo off

set DOT_PREREQUISITES_CHECK=7z nuget git jq curl gitversion "C:\Program Files\dotnet\sdk" dotnet npm standard-version
set DOT_PREREQUISITES_CHOCO="7zip.install" "nuget.commandline" "git.install" "git" "jq" "curl" "gitversion.portable --pre" "dotnetcore-sdk" "dotnetcore" "nodejs-lts"
set DOT_PREREQUISITES_NPM=standard-version


if "%~1" neq "check" goto :start
call :check_prerequisites
exit /b %ERRORLEVEL% 


:start
call :elevate_privileges
if %ERRORLEVEL% equ 1 exit /b

call :install_choco
call :choco_prerequisites
call :npm_prerequisites
goto :eof


:npm_prerequisites

call :npm_install "standard-version"
rem for %%p in (%DOT_PREREQUISITES_NPM%) do echo %%p&call :npm_install %%p
goto :eof


:npm_install
title npm is installing "%~1"...
start /wait "npm is installing %~1" cmd /c npm -g install %~1
set EXITCODE=%ERRORLEVEL%
if %EXITCODE% neq 0 pause&exit %EXITCODE%
title  
goto :eof 


:check_prerequisites
set DOT_PREREQUISITE_IS_MISSING=0
for %%p in (%DOT_PREREQUISITES_CHECK%) do call :check_prerequisite %%p
exit /b %DOT_PREREQUISITE_IS_MISSING%



:choco_prerequisites
for %%p in (%DOT_PREREQUISITES_CHOCO%) do call :choco_install_prerequisite %%p
goto :eof


:install_choco
title Checking choco...
choco -v 1>2>nul || goto :install
goto :configure
:install
title Installing choco...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command " [System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:configure
choco feature enable -n allowGlobalConfirmation > nul
choco feature enable -n exitOnRebootDetected > nul
goto :eof




:choco_install_prerequisite
title Choco is installing "%~1"...
choco install %~1
set EXITCODE=%ERRORLEVEL%
rem this is where npm is not going through
if %EXITCODE% neq 0 pause&exit %EXITCODE%
title  
goto :eof 



:check_prerequisite
if exist "%~1" goto :eof
where %~1 >nul 2>nul
if %ERRORLEVEL% neq 0 set DOT_PREREQUISITE_IS_MISSING=1&echo %~1 is missing
goto :eof


:elevate_privileges
setlocal enableextensions
cd /d "%~dp0"
net session 2> nul 1> nul
if %ERRORLEVEL% equ 0 goto :eof
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Start-Process -Wait -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0%~nx0\"' -Verb runAs"
exit /b 1

