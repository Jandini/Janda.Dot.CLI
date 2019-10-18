@call _dots %~n0 "Run build for default or all solutions defined in .dotset file" "[all]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

.foreach dotnet build %1