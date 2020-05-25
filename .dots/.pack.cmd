@call _dots %~n0 "Run (*resursively) dotnet pack for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file" "[*|.]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run (*resursively) dotnet pack for project in .current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file
rem ::: 

if "%1" equ "*" goto foreach 

rem Check if the command is overriden by the same script existing in root folder of dot repository
if exist .\%~n0.cmd call .\%~n0.cmd&goto :eof

.dotnet pack %1
goto :eof


:foreach
.foreach dotnet pack %2


