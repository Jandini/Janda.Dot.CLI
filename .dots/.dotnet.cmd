@call _dots %~n0 %* --require-dot --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dotnet wrapper
rem ::: 
rem ::: .DOTNET <command> [.] [--verbose]
rem :::         build [--release]
rem ::: 
rem ::: Parameters: 
rem :::     command - available commands are clean|restore|pack|build|run|test|graph
rem :::     . - Execute the command within current directory. Project or solution must be present in the directory.
rem :::     verbose - display dotnet calls with arguments
rem ::: 
rem ::: Description: 
rem :::     Execute dotnet command for all projects within solution(s) or current project directory. 
rem :::     The default solution name is represented by the repository directory name. 
rem :::     If the default solution file is not found then DOT_BUILD_SOLUTIONS variable from .dotconfig is used. 
rem :::     Every "command" can be overridden by adding .command.cmd script in the root of dot repository.
rem ::: 


rem configure nuget sources DOT_NUGET_SOURCES
call _dotnugets

rem Allow to override the entire dotnet command by adding .command.cmd script in root of the dot repository
if exist .\.%~n1.cmd .\.%~n1.cmd

rem get solution name
call :configure-source "%~2"
if %ERRORLEVEL% equ 1 goto :dotnet-solutions

REM DISPLAY NAME ? DO WE NEED THAT TO BE PASSED INTO EXECUTE ?????
call :dotnet-execute "%~1" "%SOURCE_SOLUTION_NAME%" "%SOURCE_DISPLAY_NAME%" 
goto :eof


:dotnet-solutions
echo Default solution was not found. Running all solutions defined in %DOT_CONFIG% file... 
if "%DOT_BUILD_SOLUTIONS%" equ "" echo %%DOT_BUILD_SOLUTIONS%% is not defined.&&goto :eof
for %%S in ("%DOT_BUILD_SOLUTIONS:;=" "%") do if "%%S" neq "" call :dotnet-execute %1 "%%S.sln" "%%S"
goto :eof


:dotnet-execute
set AVAILABLE_COMMANDS=run pack build restore test clean graph
for %%S in (%AVAILABLE_COMMANDS%) do if "%%S" equ "%~1" call :%~1 "%~2" "%~3"&exit /b %ERRORLEVEL%
echo Invalid dotnet command.
goto :eof


rem Select source project or default solution
rem Returns ERRORLEVEL=1 if default solution does not exist

:configure-source
if /i "%~1" equ "." goto :this

call _dotsrc
if %ERRORLEVEL% neq 0 exist /b 1

rem use default solution
set SOURCE_SOLUTION_NAME=%DOT_BASE_NAME%.sln
if not exist %SOURCE_SOLUTION_NAME% exit /b 1
set SOURCE_DISPLAY_NAME=%SOURCE_SOLUTION_NAME%
goto :eof


:this
cd %DOT_CURRENT_DIR_PATH%
set SOURCE_SOLUTION_NAME=
set SOURCE_DISPLAY_NAME=%DOT_CURRENT_DIR_NAME%
goto :eof


:pack
echo Packing %~2...
set DOT_BUILD_CONFIGURATION=Release
if defined DOT_ARG_VERBOSE echo dotnet pack "%~1" --configuration %DOT_BUILD_CONFIGURATION% /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES%
dotnet pack "%~1" --configuration %DOT_BUILD_CONFIGURATION% /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:build 
if "%~1" neq "" set DOT_BUILD_SOLUTION="%~1" 

set DOT_BUILD_CONFIGURATION=Debug
if defined DOT_ARG_RELEASE set DOT_BUILD_CONFIGURATION=Release
if defined DOT_ARG_VERBOSE echo dotnet build %DOT_BUILD_SOLUTION%/p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES% -c %DOT_BUILD_CONFIGURATION%
echo Building %~2 (%DOT_BUILD_CONFIGURATION%)...
dotnet build %DOT_BUILD_SOLUTION%/p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES% -c %DOT_BUILD_CONFIGURATION%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:restore
echo Restoring %~2...
if defined DOT_ARG_VERBOSE echo dotnet restore "%~1" %DOT_NUGET_SOURCES%
dotnet restore "%~1" %DOT_NUGET_SOURCES%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:test
echo Testing %~2...
if defined DOT_ARG_VERBOSE echo dotnet test "%~1"
dotnet test "%~1"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:run
if /i "%DOT_PUBLISH_PROJECTS%" equ "" echo No projects defined in %%DOT_PUBLISH_PROJECTS%%&goto :eof
for %%S in ("%DOT_PUBLISH_PROJECTS:;=" "%") do if "%%S" neq "" call :run_project %%S
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof


:run_project
echo Running %~1...
if defined DOT_ARG_VERBOSE echo dotnet run --project "%~1"
dotnet run --project "%~1"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof


:clean
echo Cleaning %~2...
if defined DOT_ARG_VERBOSE echo dotnet clean "%~1"
dotnet clean "%~1"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo Searching for bin and obj folders...
for /d /r . %%d in (bin,obj) do call :remove_dir "%%d"
goto :eof


:graph
echo Generating restore graph file for %~2...
set OUTPUT_FILE=%~n1.dg
if "%~1" equ "" set OUTPUT_FILE=%~n2.dg
echo Creating %OUTPUT_FILE%
if defined DOT_ARG_VERBOSE echo dotnet msbuild %~1 /t:GenerateRestoreGraphFile /p:RestoreGraphOutputPath=%OUTPUT_FILE%
dotnet msbuild %~1 /t:GenerateRestoreGraphFile /p:RestoreGraphOutputPath=%OUTPUT_FILE%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof


:remove_dir
if not exist "%~1" goto :eof 
echo Deleting %~1
rd /s/q "%~1"
goto :eof

