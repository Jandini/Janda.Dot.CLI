@call _dots %~n0 "Create new repository and solution from template" "[.|new solution name]" "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" neq "." goto named_solution

echo Creating %BASE_NAME%...
dotnet new dotsln
goto init

:named_solution
echo Creating %1...
dotnet new dotsln -n %1
cd %1

:init
call .init
git add .
git commit -m "Add solution"

