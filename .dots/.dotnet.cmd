@call _dots %~n0 "Run dotnet command for project in current folder, repo's default solution or all DOT_BUILD_SOLUTIONS defined in %DOT_CONFIG% file" "<pack|build|restore> [.|all]" "d 1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if /i "%2" equ "." goto this
if /i "%2" equ "all" goto foreach
if /i "%2" equ "sln" set SLN_NAME=%~3.sln&& goto dotnet
set SLN_NAME=%DOT_BASE_NAME%.sln
goto dotnet

:this
set SLN_NAME=
set DISPLAY_NAME=%DOT_CURRENT_DIR_NAME%
cd %DOT_CURRENT_DIR_PATH%
goto execute


:dotnet
cd src
if exist %SLN_NAME% goto use_default 
rem if running through foreach already exit the call
if /i "%2" equ "sln" exit /b

echo Default solution %SLN_NAME% not found. Running all solutions defined in %DOT_CONFIG% file... 
goto foreach

:use_default
set DISPLAY_NAME=%SLN_NAME%

:execute

if not defined DOT_LOCAL_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%USERPROFILE%\.nuget\local
if /i "%1" equ "pack" goto pack 
if /i "%1" equ "build" goto build
if /i "%1" equ "restore" goto restore

goto exit

:pack
echo Packing %DISPLAY_NAME%...
dotnet pack %SLN_NAME% --configuration Release --ignore-failed-sources /p:ApplyVersioning=true /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED%
goto exit

:build 
echo Building %DISPLAY_NAME%...
dotnet build %SLN_NAME% --ignore-failed-sources 
goto exit

:restore
echo Restoring %DISPLAY_NAME%...
dotnet restore %SLN_NAME% --ignore-failed-sources /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED%
goto exit

:foreach
if "%DOT_BUILD_SOLUTIONS%" equ "" echo %%DOT_BUILD_SOLUTIONS%% is not defined.&&goto exit

for %%S in ("%DOT_BUILD_SOLUTIONS:;=" "%") do if "%%S" neq "" call %~n0 %1 sln %%S 

:exit

