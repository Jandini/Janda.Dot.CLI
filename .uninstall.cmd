@call _dots %~n0 "Uninstall package" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .version
set PACKAGE=%BASE_NAME%
echo Uninstalling %PACKAGE%
dotnet new -u %PACKAGE% > nul

dotnet new -l

