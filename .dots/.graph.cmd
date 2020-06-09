@call _dots %~n0 "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Generate restore graph file
rem ::: 
rem ::: .GRAPH [*|.]
rem ::: 


if "%1" equ "*" goto foreach 

.dotnet graph %1
goto :eof

:foreach
.foreach dotnet graph %2


