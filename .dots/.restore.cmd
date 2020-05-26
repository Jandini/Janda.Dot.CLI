@call _dots %~n0 "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run (*resursively) dotnet restore for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file
rem ::: 
rem ::: .RESTORE [*|.]
rem ::: 


if "%1" equ "*" goto foreach 

.dotnet restore %1
goto :eof

:foreach
.foreach dotnet restore %2


