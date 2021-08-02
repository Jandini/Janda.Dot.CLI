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
if exist %~n0.cmd %~n0.cmd


call _dotsrc
if %ERRORLEVEL% neq 0 exit /b 1

call .dotnet pack %*
call :AddToLocal
goto :eof


:AddToLocal
:: The for will stop entire script if no DOT_NUGET_PROJECTS is available. 
if not defined DOT_NUGET_PROJECTS goto :eof
if "%DOT_NUGET_PROJECTS%" equ "" goto :eof


set DOT_GIT_VERSION=
for /f %%i in ('gitversion /showvariable SemVer') do set DOT_GIT_VERSION=%%i
if "%DOT_GIT_VERSION%" equ "" echo Get version failed.&goto :eof
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

for %%R in ("%DOT_NUGET_PROJECTS:;=" "%") do if "%%R" neq "" call :AddPackage %%R
goto :eof



:AddPackage
:: Find output bin dir. In the past it was bin for both Debug and Release configuraitons.
:: Newer repositories uses Debug or Release foldres.
set BIN_DIR=..\bin
if exist ..\bin\%DOT_BUILD_CONFIGURATION% set BIN_DIR=..\bin\%DOT_BUILD_CONFIGURATION%

set PACKAGE_NAME=%~1.%DOT_GIT_VERSION%.nupkg
nuget add %BIN_DIR%\%PACKAGE_NAME% -source %DOT_LOCAL_NUGET_FEED%
goto :eof


