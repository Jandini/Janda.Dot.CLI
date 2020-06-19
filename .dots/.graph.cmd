@_dotnet graph %~1
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem ::: Dotnet graph
rem ::: 
rem ::: .GRAPH [*|.]
rem ::: 
rem ::: Parameters: 
rem :::     * - Search and run the command for each dot repository found.
rem :::     . - Run the command for current directory only.
rem ::: 
rem ::: Description: 
rem :::     Run the command for solution(s) found in dot repository.
rem :::     For more details see .dotnet --help
rem ::: 

