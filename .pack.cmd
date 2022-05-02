@echo off

rem make sure that _* scripts are available during packing
set DOT_LOCAL_PATH=.\.dots\
set PATH | find "%LOCAL_DOTS%" > nul
if %ERRORLEVEL% neq 0 set PATH=%DOT_LOCAL_PATH%;%PATH%

:: Clear variables with multiline values that breaks args paraser 
set ViewClient_Displays.TopologyV3=

echo Building dots package...

call .\.dots\_dots %~n0 "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .\.dots\.version > nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem call :build_nuspec_file


rem by default output to bin within current folder
rem output can be overriden by setting OUTPUT_DIR variable
if "%OUTPUT_DIR%" equ "" set OUTPUT_DIR=bin



rem Add current dot version to template.config files
call :prepare_templates

set PACKAGE=%DOT_BASE_NAME%.%DOT_GIT_VERSION%.nupkg
echo %DOT_GIT_VERSION% > %DOT_LOCAL_PATH%.dotversion

echo Packing %PACKAGE%...
nuget pack .nuspec -OutputDirectory %OUTPUT_DIR% -NoDefaultExcludes -Version %DOT_GIT_VERSION% -Properties "NoWarn=NU5105;Version=%DOT_GIT_VERSION%;"

if %ERRORLEVEL% neq 0 call :revert_templates %ERRORLEVEL% "Nuget pack failed."

echo Checking %PACKAGE% in %OUTPUT_DIR%...
if not exist %OUTPUT_DIR%\%PACKAGE% call :revert_templates -1 "Cannot find package %PACKAGE% in %OUTPUT_DIR%"

call :revert_templates


if "%1" equ "noinstall" goto :eof


echo Installing templates...
dotnet new -i %OUTPUT_DIR%\%PACKAGE% > nul
if %ERRORLEVEL% neq 0 echo "Installation failed."
echo Templates %DOT_GIT_VERSION% installed successfully.


if exist %DOT_PATH_GLOBAL% del /q %DOT_PATH_GLOBAL%\*.* 
if not exist %DOT_PATH_GLOBAL% mkdir %DOT_PATH_GLOBAL% 2>nul 

echo Copying dots to %DOT_PATH_GLOBAL% 
copy %DOT_PATH%\*.cmd %DOT_PATH_GLOBAL% > nul 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Adding .dotversion file...
echo %DOT_GIT_VERSION% > %DOT_PATH_GLOBAL%.dotversion
echo Build complete.
goto :eof


:revert_templates
if "%~2" neq "" echo %~2

rem echo Restoring templates...
for /f %%f in ('dir /b /s template.json') do if exist %%f.org move %%f.org %%f > nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
if "%1" neq "" exit %1
rem echo Templates reverted.
goto :eof


:prepare_templates
call :revert_templates
rem echo Preparing templates...
for /f %%f in ('dir /b /s template.json') do call :update_template %%f
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
rem echo Templates version set to %DOT_GIT_VERSION%
goto :eof


:update_template
move "%~1" "%~1.org" > nul 
type "%~1.org" | jq --arg version %DOT_GIT_VERSION% ".classifications += [$version]" > "%~1"
if %ERRORLEVEL% neq 0 call :revert_templates -1 "%~1"
goto :eof



