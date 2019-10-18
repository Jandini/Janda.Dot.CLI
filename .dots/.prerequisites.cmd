@call _dots %~n0 "Install prerequisites" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

cd /d "%~dp0" && call _elevate %~n0
if %ERRORLEVEL% equ 1 exit /b

echo .dots choco
choco -v 1>2>nul || goto install_choco
goto install_prerequisites
:install_choco
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
rem this command stops scrip when no network is availabe
choco feature enable -n allowGlobalConfirmation 1>2>nul
:install_prerequisites
echo .dots nuget
nuget 1>2>nul || choco install nuget.commandline
echo .dots 7z 
7z 1>2>nul || choco install 7zip.install
echo .dots git
git --version 1>2>nul || choco install git.install
echo .dots jq
jq --help 1>2>nul || choco install jq
echo .dots curl
curl --help 1>2>nul || choco install curl
echo .dots gitversion
rem checking gitversion after the repo is initialized
gitversion 1>2>nul || choco install gitversion.portable --pre
