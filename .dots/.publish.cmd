@call _dots %~n0 "Run dotnet publish all projects defined in %DOT_CONFIG% file under DOT_PUBLISH_PROJECTS for every runtime defined in DOT_RUNTIME_IDENTIFIERS" "" "d" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if /i "%DOT_PUBLISH_PROJECTS%" equ "" echo No projects defined in %%DOT_PUBLISH_PROJECTS%% && exit /b
if defined DOT_LOCAL_NUGET_FEED set DOT_LOCAL_NUGET_FEED_PARAMETER= /p:PackageTargetFeed=%DOT_LOCAL_NUGET_FEED%

cd src

for %%S in ("%DOT_PUBLISH_PROJECTS:;=" "%") do if "%%S" neq "" call :publish_runtime %%S
goto :eof


:publish_runtime:
for %%R in ("%DOT_RUNTIME_IDENTIFIERS:;=" "%") do if "%%R" neq "" call :publish_project %1 %%R
goto :eof



:publish_project
echo Publishing %1 for runtime %2...

dotnet publish %1 %DOT_PUBLISH_ARGUMENTS% --runtime %2 --ignore-failed-sources /p:ApplyVersioning=true%DOT_LOCAL_NUGET_FEED_PARAMETER%
if %ERRORLEVEL% equ 0 echo %1 published successfully.
echo.
goto :eof


