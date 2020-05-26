@call _dots %~n0 "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Add new solution to the repository
rem ::: 
rem ::: .ADDSLN <.|[.]new solution name>
rem ::: 

SET SOLUTION_NAME=%1
SET SLN_NAME=%SOLUTION_NAME%

if "%SOLUTION_NAME:~0,1%"=="." set SLN_NAME=%DOT_BASE_NAME%.%SOLUTION_NAME:~1%
if "%SOLUTION_NAME%" equ "." set SLN_NAME=%DOT_BASE_NAME%

pushd src

echo Adding %SLN_NAME% solution
dotnet new sln -n %SLN_NAME%

popd