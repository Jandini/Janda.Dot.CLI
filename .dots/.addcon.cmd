@call _dots %~n0 "Add new console application to existing or new solution" "<.|[.]new application name> [existing or new solution full name] [--addArgs]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set ARGS_FLAG=--addArgs

if "%2" equ "%ARGS_FLAG%" (set PARAM_ADD_ARGS=%2) else (set PARAM_SLN_NAME=%2) 
if "%3" equ "%ARGS_FLAG%" set PARAM_ADD_ARGS=%3 && set PARAM_SLN_NAME=%2
 

set SOLUTION_NAME=%DOT_BASE_NAME%
if "%PARAM_SLN_NAME%" neq "" set SOLUTION_NAME=%PARAM_SLN_NAME%
set SOLUTION_FILE=%SOLUTION_NAME%.sln


SET APPLICATION_NAME=%1
SET APP_NAME=%APPLICATION_NAME%
if "%APPLICATION_NAME:~0,1%"=="." set APP_NAME=%DOT_BASE_NAME%.%APPLICATION_NAME:~1%
if "%APPLICATION_NAME%" equ "." set APP_NAME=%DOT_BASE_NAME%


pushd src
dotnet new dotcon -n %APP_NAME% %PARAM_ADD_ARGS%
dotnet new dotprj -n %APP_NAME%.Abstractions
move "%APP_NAME%\I*.cs" "%APP_NAME%.Abstractions"

cd "%APP_NAME%.Abstractions"
dotnet add package Microsoft.Extensions.Logging
cd..

if not exist %SOLUTION_FILE% echo Creating %SOLUTION_FILE% && dotnet new sln -n %SOLUTION_NAME%
echo Adding %APP_NAME% application to %SOLUTION_FILE%
dotnet sln %SOLUTION_FILE% add %APP_NAME%
dotnet sln %SOLUTION_FILE% add %APP_NAME%.Abstractions


find "PUBLISH_PRJ=" ..\.dotconfig >nul
if %ERRORLEVEL% neq 0 echo PUBLISH_PRJ=%APP_NAME%>>..\.dotconfig

echo Restoring packages for %APP_NAME%
dotnet restore %APP_NAME% --ignore-failed-sources 
dotnet restore %APP_NAME%.Abstractions --ignore-failed-sources 
popd