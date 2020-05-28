@call _dots %~n0 "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run (*resursively) dotnet clean for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file
rem ::: 
rem ::: .CLEAN [*|.]
rem ::: 

if "%1" equ "*" goto foreach 

call .dotnet clean %1
echo Searching for bin and obj folders...
for /d /r . %%d in (bin,obj) do call :remove_dir "%%d"
goto :eof

:foreach
.foreach dotnet clean %2
goto :eof



:remove_dir
if not exist "%~1" goto :eof 
echo Deleting %~1
rd /s/q "%~1"
goto :eof


