@call _dots %~n0 "Uninstall package" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b
call .version

rem dotnet 3.0.0 only requires NUGET_ID
set PACKAGE=%BASE_NAME%
echo Uninstalling %PACKAGE%...
dotnet new -u %PACKAGE% 


rem dotnet 2.2 requires NUGET_ID with version
rem set PACKAGE=%BASE_NAME%.%DOT_GIT_VERSION%
rem echo Uninstalling %PACKAGE%
rem dotnet new -u %PACKAGE% > nul
rem dotnet new -l

