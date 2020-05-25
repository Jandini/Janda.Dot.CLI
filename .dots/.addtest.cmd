@call _dots %~n0 "Add new xUnit test project to existing or new solution" "<.|[.]new test project name> [existing or new solution full name]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Add new xUnit test project to existing or new solution
rem ::: 

rem the . creates class library project with the same as default solution name or indicates that the name should be added to base name

rem by default solution name is the current folder
set SOLUTION_NAME=%DOT_BASE_NAME%

rem if new solution is not provided 
if "%2" neq "" set SOLUTION_NAME=%2

set SOLUTION_FILE=%SOLUTION_NAME%.sln

SET LIBRARY_NAME=%1
SET LIB_NAME=%LIBRARY_NAME%
if "%LIBRARY_NAME:~0,1%"=="." set LIB_NAME=%DOT_BASE_NAME%.%LIBRARY_NAME:~1%
if "%LIBRARY_NAME%" equ "." set LIB_NAME=%DOT_BASE_NAME%

pushd src

dotnet new xunit -n %LIB_NAME%

if not exist %SOLUTION_FILE% echo Creating %SOLUTION_FILE% && dotnet new sln -n %SOLUTION_NAME%
echo Adding %LIB_NAME% application to %SOLUTION_FILE%
dotnet sln %SOLUTION_FILE% add %LIB_NAME%

echo Restoring packages for %LIB_NAME%
dotnet restore %LIB_NAME% --ignore-failed-sources 

popd