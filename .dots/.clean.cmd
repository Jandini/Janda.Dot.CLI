@call _dots %~n0 "Run (*resursively) dotnet clean for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file" "[*|.]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "*" goto foreach 

.dotnet clean %1
goto :eof

:foreach
.foreach dotnet clean %2


