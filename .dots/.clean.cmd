@.dotnet clean %*
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem ::: Dotnet clean
rem ::: 
rem ::: .CLEAN [.]
rem ::: 
rem ::: Parameters: 
rem :::     . - Run for project within current directory only
rem ::: 
rem ::: Description: 
rem :::     Wrapper over .dotnet command. Run this command for solution(s) found in dot repository.
rem :::     For more details see .dotnet --help
rem ::: 

