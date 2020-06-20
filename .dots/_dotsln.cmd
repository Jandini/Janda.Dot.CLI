
rem by default solution name is the current folder
set SOLUTION_NAME=%DOT_BASE_NAME%

rem if the --solution parameter was provided then use the provided name
if defined DOT_ARG_SOLUTION set SOLUTION_NAME=%DOT_ARG_SOLUTION%

rem make solution file name variable 
set SOLUTION_FILE=%SOLUTION_NAME%.sln

rem create solution if not exists
if not exist %SOLUTION_FILE% echo Creating %SOLUTION_FILE% && dotnet new sln -n %SOLUTION_NAME%

rem only if parameter was provide
if "%~1" equ "" goto :eof

rem add the project to solution
echo Adding %~1 application to %SOLUTION_FILE%
dotnet sln %SOLUTION_FILE% add "%~1"

echo Restoring packages for %~1
dotnet restore %~1 --ignore-failed-sources 
