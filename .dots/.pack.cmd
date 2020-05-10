@call _dots %~n0 "Run (*resursively) dotnet pack for project in .current folder, repo's default solution or all BUILD_SLN defined in .dotconfig file" "[*|.|all]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "*" goto foreach 

.dotnet pack %1

:foreach
.foreach dotnet pack %2


