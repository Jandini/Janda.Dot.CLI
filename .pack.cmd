@call _dots %~n0 "Create and install nuget package" "" %1 %2 %3
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

echo Updating templates...
for /f %%f in ('dir /b /s template.json') do move %%f %%f.org > nul && type %%f.org | jq --arg version %VERSION% ".classifications += [$version]" > %%f

set DOTS=.dots\.dots.cmd

rem todo: try to save version in a file and use it so there's no need to generate static file 
echo @call _dots %%~n0 "Install global dots or upgrade local dots" "[install^|upgrade]" %%1 %%2 %%3 > %DOTS%
echo if %%ERRORLEVEL%% equ 1 exit /b >> %DOTS%
echo echo .dots %VERSION% %%DOTS_TYPE%% >> %DOTS%
echo set PARAM=%%1 >> %DOTS%
echo if /i "%%PARAM:~0,2%%" neq "up" goto install >> %DOTS%
echo if "%%DOTS_TYPE%%" neq "local" goto exit >> %DOTS%
echo dotnet new dots --force >> %DOTS%
echo call .dots >> %DOTS%
echo goto exit >> %DOTS%
echo :install >> %DOTS%
echo if /i "%%PARAM:~0,1%%" neq "i" goto exit >> %DOTS%
echo if "%%DOTS_TYPE%%" neq "local" goto exit >> %DOTS%
echo mkdir %%DOTS_GLOBAL%% 2^>nul >> %DOTS%
echo copy %%DOTS_PATH%%\*.cmd %%DOTS_GLOBAL%% ^> nul >> %DOTS%
echo echo .dots copied to %%DOTS_GLOBAL%% >> %DOTS%
echo if "%%2" equ "noprereq" goto exit >> %DOTS%
echo .prerequisites >> %DOTS%
echo :exit >> %DOTS%



set PACKAGE=%BASE_NAME%.%VERSION%.nupkg
echo Packing dots-cli to %PACKAGE%...
nuget pack .nuspec -OutputDirectory %OUTPUT_DIR% -NoDefaultExcludes -Version %VERSION% -Properties NoWarn=NU5105
set LAST_ERRORLEVEL=%ERRORLEVEL%
if %LAST_ERRORLEVEL% neq 0 goto cleanup

echo Checking if %PACKAGE% exists...
dir %OUTPUT_DIR%\%PACKAGE% 1>nul 2>nul
set LAST_ERRORLEVEL=%ERRORLEVEL%
if %LAST_ERRORLEVEL% neq 0 goto cleanup

:cleanup
echo Running cleanup...
for /f %%f in ('dir /b /s template.json') do move %%f.org %%f > nul
if %LAST_ERRORLEVEL% neq 0 echo Exiting with error %LAST_ERRORLEVEL% && exit /b %LAST_ERRORLEVEL%

if "%1" equ "noinstall" goto exit

dotnet new -i %OUTPUT_DIR%\%PACKAGE%
.dots install noprereq
:exit
