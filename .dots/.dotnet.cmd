@call _dots %~n0 "Run dotnet for project in current folder, repo's default solution or solutions in DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file" "<clean|restore|pack|build|publish|test> [.]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: This is dot wrapper over the dotnet command. 

rem configure nuget sources DOT_NUGET_SOURCES
call _dotnugets

rem get solution name
call :configure-source %2
if %ERRORLEVEL% equ 1 goto :dotnet-solutions

call :dotnet-execute %1 "%SOURCE_SOLUTION_NAME%" "%SOURCE_DISPLAY_NAME%" 
goto :eof


:dotnet-solutions
echo Default solution %SOURCE_SOLUTION_NAME% not found. Running all solutions defined in %DOT_CONFIG% file... 
if "%DOT_BUILD_SOLUTIONS%" equ "" echo %%DOT_BUILD_SOLUTIONS%% is not defined.&&goto :eof
for %%S in ("%DOT_BUILD_SOLUTIONS:;=" "%") do if "%%S" neq "" call :dotnet-execute %1 "%%S.sln" "%%S"
goto :eof



:dotnet-execute
if /i "%1" equ "pack" call :pack "%~2" "%~3" & goto :eof
if /i "%1" equ "build" call :build "%~2" "%~3" & goto :eof
if /i "%1" equ "restore" call :restore "%~2" "%~3" & goto :eof
if /i "%1" equ "test" call :test "%~2" "%~3" & goto :eof
if /i "%1" equ "clean" call :clean "%~2" "%~3" & goto :eof

echo Invalid dotnet command.
goto :eof




rem Select source project or default solution
rem Returns ERRORLEVEL=1 if default solution does not exist
:configure-source
if /i "%~1" equ "." goto :this

cd src
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
dotnet pack "%~1" --configuration Release /p:ApplyVersioning=true /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:build 
echo Building %~2...
dotnet build "%~1" /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% %DOT_NUGET_SOURCES%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:restore
echo Restoring %~2...
dotnet restore "%~1" %DOT_NUGET_SOURCES%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:test
echo Testing %~2...
dotnet test "%~1"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof


:clean
echo Cleaning %~2...
dotnet clean "%~1"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof
