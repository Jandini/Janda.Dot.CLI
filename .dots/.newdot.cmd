@call _dots %~n0 "Create new dot repository with default solution from template" "[.|new repository name]" "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set ERRORM_ESSAGE=
if "%1" neq "." goto named_solution

echo Creating %DOT_BASE_NAME%...
dotnet new dotrepo
if %ERRORLEVEL% neq 0 goto template_error
goto init

:named_solution
echo Creating %1...
dotnet new dotrepo -n %1
if %ERRORLEVEL% neq 0 goto template_error
cd %1

:init
call .init
git add .
git commit -m "Create dot repository"
goto exit

:template_error
echo.
echo Creating dotrepo template failed. Make sure dots-cli templates are installed. 
exit /b 1

:exit