@call _dots %~n0 %* --require-dot --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add solution
rem ::: 
rem ::: .ADDSLN <.|[.]solution name>
rem ::: 
rem ::: Parameters: 
rem :::     solution name - New solution name to be added
rem ::: 
rem ::: Description: 
rem :::     Add new solution to the repository. 
rem ::: 


call _dotname "%~1" SLN_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo Adding %SLN_NAME% solution
dotnet new sln -n %SLN_NAME%
exit /b %ERRORLEVEL%