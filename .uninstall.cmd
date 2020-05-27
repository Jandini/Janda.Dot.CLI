@call _dots %~n0 %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Uninstall package
rem ::: 
rem ::: .UNINSTALL
rem ::: 

call .version

rem dotnet 3.0.0 only requires NUGET_ID
set PACKAGE=%DOT_BASE_NAME%
echo Uninstalling %PACKAGE%...
dotnet new -u %PACKAGE% 

