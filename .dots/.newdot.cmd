@call _dots %~n0 " G1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Create new dot repository with default solution from template
rem ::: 
rem ::: .NEWDOT [.|new repository name]
rem ::: 

set ERRORM_ESSAGE=
if "%1" neq "." goto named_solution

rem check if there are no git repositories in subolders
for /d /r . %%i in (.git\index) do if exist %%i echo %~n0 cannot run over git repository in %%i&exit /b 1

echo Creating %DOT_BASE_NAME%...
dotnet new dotrepo
if %ERRORLEVEL% neq 0 goto template_error
goto init

:named_solution
if exist %1 echo %1 already exist.&exit /b 1 
echo Creating %1...
dotnet new dotrepo -n %1
if %ERRORLEVEL% neq 0 call :template_error
cd %1

:init
git init
git add .
git commit -m "chore: Create repository"
call .init
rem don't use hooks until conventional commits regex supports merge commits
rem dotnet new dotgithooks -n .git
goto :eof



:template_error
echo.
echo Creating dotrepo template failed. Make sure Janda.Dots.CLI templates are installed. 
exit /b 1
