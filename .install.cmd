@echo off
cls
cd /d "%~dp0"& call _elevate.cmd %~nx0 > nul
if %ERRORLEVEL% equ 1 exit /b

call :echo_stage "Installing prerequisites..."
call _prerequisites skip existing
if %ERRORLEVEL% neq 0 exit /b

call :echo_stage "Building dots nuget package..."
call .pack
call :echo_stage "Installation complete."
timeout 30

goto :eof


:echo_stage
title %~1
echo %~1
break;



