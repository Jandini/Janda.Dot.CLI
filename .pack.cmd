@call _dots %~n0 "Create and install nuget package" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

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

echo Updating version tags
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
echo if "%1" equ "noprereq" goto exit >> %DOTS%
echo .prerequisites >> %DOTS%
echo :exit >> %DOTS%



set PACKAGE=%BASE_NAME%.%VERSION%.nupkg
nuget pack .nuspec -OutputDirectory bin -NoDefaultExcludes -Version %VERSION%
if %ERRORLEVEL% equ 0 dotnet new -i bin\%PACKAGE%

echo Removing version tags
for /f %%f in ('dir /b /s template.json') do move %%f.org %%f > nul

call .dots install noprereq