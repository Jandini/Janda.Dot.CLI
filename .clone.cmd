@echo off

:: Prepare temp for cloning
set CLONE_DIR=Janda%RANDOM%
cd "%TEMP%"
mkdir %CLONE_DIR%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
cd %CLONE_DIR%

:: Clone and pack Janda.Dot.CLI 
call :git_clone Janda.Dot.CLI

cd Janda.Dot.CLI 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call .pack
cd ..

 
:: Clone and pack Janda.Dot packages
mkdir Janda.Dot.Packages
cd Janda.Dot.Packages
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

set DOT_PACKAGES=Janda.Dot.Console Janda.Dot.Nuget Janda.Dot.Obfuscar Janda.Dot.Serilog Janda.Dot.Service Janda.Dot.Version
for %%i in (%DOT_PACKAGES%) do call :git_clone %%i
call .foreach pack
goto :eof



:git_clone
git clone https://github.com/Jandini/%~1.git
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%
goto :eof