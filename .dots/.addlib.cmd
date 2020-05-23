@call _dots %~n0 "Add new class library to existing or new solution" "<.|[.]new class library name> [--solution <existing or new solution full name>] [--namespace <namespace>]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

@call _dotargs %*
@call _dotname %1 LIBRARY_NAME

rem by default solution name is the current folder
set SOLUTION_NAME=%DOT_BASE_NAME%
if defined DOT_ARG_SOLUTION set SOLUTION_NAME=%DOT_ARG_SOLUTION%
set SOLUTION_FILE=%SOLUTION_NAME%.sln

rem check of optional namespace argument
if defined DOT_ARG_NAMESPACE set NAMESPACE_ARGUMENT=--nameSpace %DOT_ARG_NAMESPACE%


pushd src

dotnet new dotlib -n %LIBRARY_NAME% %NAMESPACE_ARGUMENT%

if not exist %SOLUTION_FILE% echo Creating %SOLUTION_FILE% && dotnet new sln -n %SOLUTION_NAME%
echo Adding %LIBRARY_NAME% application to %SOLUTION_FILE%
dotnet sln %SOLUTION_FILE% add %LIBRARY_NAME%

echo Restoring packages for %LIBRARY_NAME%
dotnet restore %LIBRARY_NAME% --ignore-failed-sources 

popd


