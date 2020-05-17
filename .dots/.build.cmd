@call _dots %~n0 "Run (*resursively) dotnet build for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file." "[*|.|all]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "*" goto foreach 

.dotnet build %1
goto :eof

:foreach
.foreach dotnet build %2
