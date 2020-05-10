@call _dots %~n0 "Run dotnet publish all projects defined in .dotconfig file under PUBLISH_PRJ" "" "d" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if /i "%PUBLISH_PRJ%" equ "" echo No projects defined in %%PUBLISH_PRJ%% && exit /b

cd src
set LOCAL_NUGET_FEED=%USERPROFILE%\.nuget\local

for %%S in ("%PUBLISH_PRJ:;=" "%") do if "%%S" neq "" echo Publishing %%S...&& dotnet publish %%S -c Release -r win7-x64 --ignore-failed-sources /p:ApplyVersioning=true /p:PackageTargetFeed=%LOCAL_NUGET_FEED%
