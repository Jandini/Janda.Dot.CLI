@call _dots %~n0 %* --require-dot
if %ERRORLEVEL% equ 1 exit /b

.dotnet build %*

rem ::: Dotnet build
rem ::: 
rem ::: .BUILD [.] [--release] [--verbose]
rem ::: 
rem ::: Parameters: 
rem :::     . - Run for project within current directory only
rem :::     release - use release configuration (-c Release)
rem :::     verbose - show executed commands 
rem ::: 
rem ::: Description: 
rem :::     Wrapper over .dotnet command. Run this command for solution(s) found in dot repository.
rem :::     For more details see .dotnet --help
rem ::: 
