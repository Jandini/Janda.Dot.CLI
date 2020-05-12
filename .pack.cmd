@call _dots %~n0 "Create and install nuget package" "" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem by default output to bin within current folder
rem output can be overriden by setting OUTPUT_DIR variable
if "%OUTPUT_DIR%" equ "" set OUTPUT_DIR=bin

rem check if path variable contains local dots location
for %%G in ("%PATH:;=" "%") do if /i %%G equ ".\.dots" goto global_path
echo You must add "%.\.dots" to PATH variable. 
exit 1

:global_path

for %%G in ("%PATH:;=" "%") do if /i %%G equ "%userprofile%\.dots" goto install
echo Adding "%%userprofile%%\.dots" to PATH variable. 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_SZ /f /d "%PATH%;%%userprofile%%\.dots"
set PATH=%PATH%;%%userprofile%%.\dots
rem to do
pause

:install

@call _dots %~n0 "Create and install nuget package" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b
 
call .version
if "%DOT_GIT_VERSION%" equ "" echo %%DOT_GIT_VERSION%% was not set & goto :eof

call :prepare_templates
set DOTS=.dots\.dots.cmd

rem todo: try to save version in a file and use it so there's no need to generate static file 
echo @rem THIS FILE WAS GENERATED BY .pack.cmd COMMAND > %DOTS%
echo @call _dots %%~n0 "Install global dots or upgrade local dots" "[install^|upgrade]" "" %%1 %%2 %%3 >> %DOTS%
echo if %%ERRORLEVEL%% equ 1 exit /b >> %DOTS%
echo echo .dots %DOT_GIT_VERSION% %%DOT_TYPE%% >> %DOTS%

rem echo echo %%DOT_TYPE%% >> %DOTS%
rem echo echo %%DOT_PATH_GLOBAL%% >> %DOTS%
rem echo echo %%DOT_PATH%% >> %DOTS%

echo set PARAM=%%1 >> %DOTS%
echo if /i "%%PARAM:~0,2%%" neq "up" goto install >> %DOTS%
echo if "%%DOT_TYPE%%" neq "local" goto exit >> %DOTS%
echo if exist .\.dots\ del /q .\.dots\*.* >> %DOTS%
echo dotnet new dots --force >> %DOTS%
echo call .dots >> %DOTS%
echo goto exit >> %DOTS%
echo :install >> %DOTS%
echo if /i "%%PARAM:~0,1%%" neq "i" goto exit >> %DOTS%
echo if "%%DOT_TYPE%%" neq "local" goto exit >> %DOTS%
echo if exist %%DOT_PATH_GLOBAL%% del /q %%DOT_PATH_GLOBAL%%\*.* >> %DOTS%
echo if not exist %%DOT_PATH_GLOBAL%% mkdir %%DOT_PATH_GLOBAL%% 2^>nul >> %DOTS%
echo copy %%DOT_PATH%%\*.cmd %%DOT_PATH_GLOBAL%% ^> nul >> %DOTS%
echo echo .dots copied to %%DOT_PATH_GLOBAL%% >> %DOTS%
echo if "%%2" equ "noprereq" goto exit >> %DOTS%
echo %%DOT_PATH%%_install.cmd >> %DOTS%
echo :exit >> %DOTS%



set PACKAGE=%DOT_BASE_NAME%.%DOT_GIT_VERSION%.nupkg
echo Packing %PACKAGE%...
nuget pack .nuspec -OutputDirectory %OUTPUT_DIR% -NoDefaultExcludes -Version %DOT_GIT_VERSION% -Properties NoWarn=NU5105
if %ERRORLEVEL% neq 0 call :revert_templates %ERRORLEVEL% "Nuget pack failed."

echo Checking %PACKAGE% in %OUTPUT_DIR%...
if not exist %OUTPUT_DIR%\%PACKAGE% call :revert_templates -1 "Cannot find package %PACKAGE% in %OUTPUT_DIR%"
call :revert_templates


if "%1" equ "noinstall" goto :eof


echo Installing templates...
dotnet new -i %OUTPUT_DIR%\%PACKAGE% > nul
if %ERRORLEVEL% neq 0 echo "Installation failed."
echo Templates %DOT_GIT_VERSION% installed successfully.

echo Installing dots...
call .dots install noprereq
echo Dots installed successfully.
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
