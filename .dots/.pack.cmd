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
rem ::: 


call _dotsrc
call :DotNuget add %DOT_NUGET_SOURCES%
call .dotnet pack %*
call :DotNuget remove
goto :eof


:DotNuget
for %%R in ("%DOT_NUGET_PROJECTS:;=" "%") do if "%%R" neq "" call :DotNugetAddRemove %1 %%R %2
goto :eof

:DotNugetAddRemove
echo Performing %1 package Janda.Dot.Nuget for project %2...
dotnet %1 %2 package Janda.Dot.Nuget %3
if %ERRORLEVEL% neq 0 exit 
goto :eof


