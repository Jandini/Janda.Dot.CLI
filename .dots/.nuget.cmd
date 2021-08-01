@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots nuget
rem ::: 
rem ::: .NUGET [--pack] 
rem :::        [--delete branch|nonalpha] [--branch name]
rem :::        [--push] [--yes]
rem ::: 
rem ::: Parameters: 
rem :::     pack - pack nuget package from .nuspec file
rem :::     push - push nuget package to given nuget source with DOT_NUGET_SOURCE_URL 
rem :::            Default is https://api.nuget.org/v3/index.json
rem :::     delete - Delete nuget packages created within current "branch" or all "nonalpha" packages
rem :::     branch - Override current branch name 
rem ::: 
rem ::: Description: 
rem :::     Create nuget package and add to dot nuget feed.
rem ::: 

if not defined DOT_NUGET_SOURCE_URL set DOT_NUGET_SOURCE_URL=https://api.nuget.org/v3/index.json
echo Using %DOT_NUGET_SOURCE_URL%

if defined DOT_ARG_PACK goto :pack_nuget
if defined DOT_ARG_PUSH goto :push_nuget


goto :eof

:pack_nuget

call :configure_nuget
call :build_nuget
call :remove_nuget
call :add_nuget
goto :eof




:push_nuget

if not defined DOT_NUGET_SOURCE_API_KEY echo DOT_NUGET_SOURCE_API_KEY was not found. Add DOT_NUGET_SOURCE_API_KEY=yourkey into .dotlocal file.&goto :eof
echo Getting semantic version...

:: using inline git version because call .version resets arguments
set DOT_GIT_VERSION=
for /f %%i in ('gitversion /showvariable SemVer') do set DOT_GIT_VERSION=%%i
if "%DOT_GIT_VERSION%" equ "" echo Get version failed.&goto :eof

if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
set PACKAGE_NAME=%DOT_BASE_NAME%.%DOT_GIT_VERSION%.nupkg

dir bin\%PACKAGE_NAME% > nul
if %ERRORLEVEL% neq 0 echo %PACKAGE_NAME% package not found in bin folder.&exit /b %ERRORLEVEL%
echo Package found in bin\%PACKAGE_NAME%

:: remember not to call .command because it resets arguments
if defined DOT_ARG_YES goto :push
set /P CONFIRM=Do you push %PACKAGE_NAME% to %DOT_NUGET_SOURCE_URL% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof

:push
dotnet nuget push bin\%PACKAGE_NAME% --api-key %DOT_NUGET_SOURCE_API_KEY% --source %DOT_NUGET_SOURCE_URL% --skip-duplicate
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
