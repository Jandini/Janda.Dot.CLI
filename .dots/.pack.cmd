@call _dots %~n0 %* --require-dot
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem ::: Dotnet pack
rem ::: 
rem ::: .PACK [.]
rem ::: 
rem ::: Parameters: 
rem :::     . - Run for project within current directory only
rem ::: 
rem ::: Description: 
rem :::     Run the command for solution(s) found in dot repository.
rem :::     For more details see .dotnet --help
rem :::     This script can automatically add dot nuget tergets before packing projects and remove after.
rem :::     Use DOT_NUGET_PROJECTS semicolon delimited variable in .dotconfig to define the project names.
rem ::: 

rem Allow to override the entire dotnet command by adding .command.cmd script in root of the dot repository
if exist .\.%~n1.cmd .\.%~n1.cmd


call _dotsrc
if %ERRORLEVEL% neq 0 exit /b 1

call :DotNuget add %DOT_NUGET_SOURCES%
call .dotnet pack %*
call :DotNuget remove
goto :eof


:DotNuget
:: The for will stop entire script if no DOT_NUGET_PROJECTS is available. 
if not defined DOT_NUGET_PROJECTS goto :eof
if "%DOT_NUGET_PROJECTS%" equ "" goto :eof
for %%R in ("%DOT_NUGET_PROJECTS:;=" "%") do if "%%R" neq "" call :DotNugetAddRemove %1 %%R %2
goto :eof

:DotNugetAddRemove
echo Performing %1 package Janda.Dot.Nuget for project %2...
dotnet %1 %2 package Janda.Dot.Nuget %3
if %ERRORLEVEL% neq 0 exit 
goto :eof


