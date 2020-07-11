@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots nuget
rem ::: 
rem ::: .NUGET [--pack] 
rem :::        [--delete branch|nonalpha] [--branch name]
rem ::: 
rem ::: Parameters: 
rem :::     pack - pack nuget package from .nuspec file
rem :::     delete - Delete nuget packages created within current "branch" or all "nonalpha" packages
rem :::     branch - Override current branch name 
rem ::: 
rem ::: Description: 
rem :::     Create nuget package and add to dot nuget feed.
rem ::: 


if defined DOT_ARG_PACK call :pack_nuget

goto :eof



:pack_nuget

call :configure_nuget
call :build_nuget
call :remove_nuget
call :add_nuget

goto :eof



:configure_nuget

echo Configuring package...
call .version %* >nul
call _dotnugets

set OUTPUT_DIR=bin
set OUTPUT_PACKAGE=%DOT_BASE_NAME%.%DOT_GIT_VERSION%.nupkg


rem set DOT_LOCAL_NUGET_FEED=%USERPROFILE%\.nuget\local
rem if defined DOT_CID_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%DOT_CID_NUGET_FEED%
goto :eof



:build_nuget
echo Packing %OUTPUT_PACKAGE%...
set NUSPEC_FILE=.nuspec
nuget pack %NUSPEC_FILE% -OutputDirectory %OUTPUT_DIR% -NoDefaultExcludes -Properties "NoWarn=NU5105;Version=%DOT_GIT_VERSION%;Id=%DOT_BASE_NAME%"
goto :eof


:add_nuget
echo Adding %OUTPUT_PACKAGE% to %DOT_LOCAL_NUGET_FEED%...
nuget add "%OUTPUT_DIR%\%OUTPUT_PACKAGE%" -source "%DOT_LOCAL_NUGET_FEED%"
goto :eof


:remove_nuget
set PACKAGE_FOLDER="%DOT_LOCAL_NUGET_FEED%\%DOT_BASE_NAME%\%DOT_GIT_VERSION%"
if not exist %PACKAGE_FOLDER% goto :eof

echo WARNING: Removing %PACKAGE_FOLDER%...
rd /s /q %PACKAGE_FOLDER%

set NUGET_SOURCE=%USERPROFILE%\.nuget\packages
set PACKAGE_FOLDER="%NUGET_SOURCE%\%DOT_BASE_NAME%\%DOT_GIT_VERSION%"

if exist %PACKAGE_FOLDER% echo WARNING: Removing %PACKAGE_FOLDER%...&rd /s /q %PACKAGE_FOLDER%
goto :eof







:remove_non_release_packages
set DOT_PSCMD="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command

echo Removing Janda.* non-release and non-alpha packages from nuget cache...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\packages'; Get-ChildItem -Path $path -Filter 'janda.*' -Directory | Get-ChildItem | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host "
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\packages'; Get-ChildItem -Path $path -Filter 'janda.*' -Directory | Get-ChildItem | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Remove-Item -Recurse "

echo Removing non-release and non-alpha packages from local nuget...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\local'; Get-ChildItem -Path $path -Recurse -Directory | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host " 
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\local'; Get-ChildItem -Path $path -Recurse -Directory | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Remove-Item -Recurse " 

goto :eof
