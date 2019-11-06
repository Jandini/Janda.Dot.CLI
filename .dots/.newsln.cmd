@call _dots %~n0 "Create new repository and default solution from template" "[.|new repository name]" "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" neq "." goto named_solution

echo Creating %DOT_BASE_NAME%...
dotnet new dotrepo
goto init

:named_solution
echo Creating %1...
dotnet new dotrepo -n %1
cd %1

:init
call .init
git add .
git commit -m "Create dot repository"

