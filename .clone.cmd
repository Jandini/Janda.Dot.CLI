@echo off
set CLONE_DIR=Janda%RANDOM%
cd "%TEMP%"
mkdir %CLONE_DIR%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
cd %CLONE_DIR%
set DOT_PACKAGES=Janda.Dot.CLI Janda.Dot.Console Janda.Dot.Nuget Janda.Dot.Obfuscar Janda.Dot.Serilog Janda.Dot.Service Janda.Dot.Version
for %%i in (%DOT_PACKAGES%) do git clone https://github.com/Jandini/%%i.git
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
call .foreach pack