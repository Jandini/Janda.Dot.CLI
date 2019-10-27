@call _dots %~n0 "Run dotnet command for project in current folder, repo's default solution or all BUILD_SLN defined in .dotset file" "<pack|build|restore> [.|all]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" .help dotnet && exit /b

if /i "%2" equ "." goto this
if /i "%2" equ "all" goto foreach
if /i "%2" equ "sln" set SLN_NAME=%~3.sln&& goto dotnet
set SLN_NAME=%BASE_NAME%.sln
goto dotnet

:this
set SLN_NAME=
set DISPLAY_NAME=%CURRENT_DIR_NAME%
cd %CURRENT_DIR_PATH%
goto execute


:dotnet
cd src
if not exist %SLN_NAME% echo Default solution %SLN_NAME% not found. Running all solutions defined in .dotset file... && goto foreach
set DISPLAY_NAME=%SLN_NAME%

:execute
set LOCAL_NUGET_FEED=%USERPROFILE%\.nuget\local
if /i "%1" equ "pack" goto pack 
if /i "%1" equ "build" goto build
if /i "%1" equ "restore" goto restore

goto exit

:pack
echo Packing %DISPLAY_NAME%...
dotnet pack %SLN_NAME% --configuration Release --ignore-failed-sources /p:ApplyVersioning=true /p:PackageTargetFeed=%LOCAL_NUGET_FEED%
goto exit

:build 
echo Building %DISPLAY_NAME%...
dotnet build %SLN_NAME% --ignore-failed-sources 
goto exit

:restore
echo Restoring %DISPLAY_NAME%...
dotnet restore %SLN_NAME% --ignore-failed-sources /p:PackageTargetFeed=%LOCAL_NUGET_FEED%
goto exit

:foreach
for %%S in ("%BUILD_SLN:;=" "%") do if "%%S" neq "" call %~n0 %1 sln %%S 

:exit

