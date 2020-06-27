@call _dots %~n0 %* --require-nogit --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots new repository
rem ::: 
rem ::: .NEWDOT <repository name|.>
rem ::: 
rem ::: Parameters: 
rem :::     repository name - new repository name
rem ::: 
rem ::: Description: 
rem :::     Create new dot repository. The "." makes the new repository name to be current folder's name.
rem ::: 


if "%~1" neq "." (call :named_solution "%~1") else (call :this_folder)
goto :eof


:this_folder

rem check if there are no git repositories in subolders
for /d /r . %%i in (.git\index) do if exist %%i echo %~n0 cannot run over git repository in %%i&exit /b 1

echo Creating %DOT_BASE_NAME%...
dotnet new dotrepo
if %ERRORLEVEL% neq 0 call :error_message %ERRORLEVEL%&exit /b %ERRORLEVEL%

call :init
goto :eof




:named_solution
if exist %1 echo %1 already exist.&exit /b 1 
echo Creating %1...
dotnet new dotrepo -n %1
if %ERRORLEVEL% neq 0 call :error_message %ERRORLEVEL%&exit /b %ERRORLEVEL%
cd %1
call :init
goto :eof


:init
git init
git add .
git commit -m "chore: Create repository"
call .init
rem don't use hooks until conventional commits regex supports merge commits
rem dotnet new dotgithooks -n .git
goto :eof



:error_message
echo.
echo Error %1: Creating dotrepo template failed. Make sure Janda.Dots.CLI templates are installed. 
exit /b %1
