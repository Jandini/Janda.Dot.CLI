@call _dots %~n0 "Add new solution to the repository" "<.|[.]new solution name>" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" .help addsln && exit /b

SET SOLUTION_NAME=%1
SET SLN_NAME=%SOLUTION_NAME%

if "%SOLUTION_NAME:~0,1%"=="." set SLN_NAME=%BASE_NAME%.%SOLUTION_NAME:~1%
if "%SOLUTION_NAME%" equ "." set SLN_NAME=%BASE_NAME%

pushd src

echo Adding %SLN_NAME% solution
dotnet new sln -n %SLN_NAME%

popd