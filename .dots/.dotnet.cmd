@call _dots %~n0 "Run dotnet command for default or all solutions defined in .dotset file" "<pack|build|restore> [all]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" .help dotnet && exit /b
if /i "%2" equ "all" goto foreach
if /i "%2" equ "sln" set SLN_NAME=%~3&& goto dotnet
set SLN_NAME=%BASE_NAME%

:dotnet
cd src
if not exist %SLN_NAME%.sln echo %SLN_NAME% not found. && goto foreach

set LOCAL_NUGET_FEED=%USERPROFILE%\.nuget\local
if /i "%1" equ "pack" echo Packing %SLN_NAME%...&& dotnet pack %SLN_NAME%.sln --configuration Release --ignore-failed-sources /p:ApplyVersioning=true /p:PackageTargetFeed=%LOCAL_NUGET_FEED%
if /i "%1" equ "build" echo Building %SLN_NAME%...&& dotnet build %SLN_NAME%.sln --ignore-failed-sources 
if /i "%1" equ "restore" echo Restoring %SLN_NAME%...&& dotnet restore %SLN_NAME%.sln --ignore-failed-sources /p:PackageTargetFeed=%LOCAL_NUGET_FEED%

goto exit

:foreach
for %%S in ("%BUILD_SLN:;=" "%") do if "%%S" neq "" call %~n0 %1 sln %%S 

:exit

