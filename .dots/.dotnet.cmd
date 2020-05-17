@call _dots %~n0 "Run dotnet for project in current folder [.], repo's default solution or solutions in DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file" "<restore|pack|build|publish|test> [.]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: This is dot wrapper over the dotnet command. 


call :configure-nugets
call :configure-source %2
if %ERRORLEVEL% equ 1 goto :dotnet-solutions

call :dotnet-execute %1 "%SOURCE_SOLUTION_NAME%" "%SOURCE_DISPLAY_NAME%" 
goto :eof


:dotnet-solutions
echo Default solution %SOURCE_SOLUTION_NAME% not found. Running all solutions defined in %DOT_CONFIG% file... 
if "%DOT_BUILD_SOLUTIONS%" equ "" echo %%DOT_BUILD_SOLUTIONS%% is not defined.&&goto :eof
for %%S in ("%DOT_BUILD_SOLUTIONS:;=" "%") do if "%%S" neq "" call :dotnet-execute %1 %%S %%S
goto :eof



:dotnet-execute
if /i "%1" equ "pack" call :pack "%~2" "%~3" & goto :eof
if /i "%1" equ "build" call :build "%~2" "%~3" & goto :eof
if /i "%1" equ "restore" call :restore "%~2" "%~3" & goto :eof

echo Invalid dotnet command.
goto :eof




rem configure-source
rem ----------------
rem Select source project or default solution
rem Returns ERRORLEVEL=1 if default solution does not exist
:configure-source
if /i "%~1" equ "." goto :this-project

cd src
rem use default solution
set SOURCE_SOLUTION_NAME=%DOT_BASE_NAME%.sln
if not exist %SOURCE_SOLUTION_NAME% exit /b 1
set SOURCE_DISPLAY_NAME=%SOURCE_SOLUTION_NAME%
goto :eof

:this-project
cd %DOT_CURRENT_DIR_PATH%
set SOURCE_SOLUTION_NAME=
set SOURCE_DISPLAY_NAME=%DOT_CURRENT_DIR_NAME%
goto :eof



rem configure-nugets
rem ----------------
:configure-nugets
rem Configure .dot nuget source and feed. .dot's local nuget feed is %USERPROFILE%\.nuget\local
rem This can be overriden by %DOT_CID_NUGET_FEED% environment variable and redirected to any folder. 
set DOT_DEFAULT_NUGET_FEED=%USERPROFILE%\.nuget\local

rem if global variable DOT_CID_NUGET_FEED e.g. on build server then make it a local path 
if defined DOT_CID_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%DOT_CID_NUGET_FEED%

rem if local path is still not then create one
if not defined DOT_LOCAL_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%DOT_DEFAULT_NUGET_FEED%
goto :eof



:pack
echo Packing %~2...
dotnet pack "%~1" --configuration Release /p:ApplyVersioning=true /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% --packages %DOT_LOCAL_NUGET_FEED% --ignore-failed-sources 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:build 
echo Building %~2...
dotnet build "%~1" /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED% --packages %DOT_LOCAL_NUGET_FEED% --ignore-failed-sources
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof

:restore
echo Restoring %~2...
dotnet restore "%~1" --ignore-failed-sources --packages %DOT_LOCAL_NUGET_FEED%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
goto :eof
