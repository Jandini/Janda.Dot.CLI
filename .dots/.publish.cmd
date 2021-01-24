@call _dots %~n0 %* --require-dot
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dotnet publish
rem ::: 
rem ::: .PUBLISH
rem ::: 
rem ::: Description: 
rem :::     Publish all projects defined in .dotconfig file under DOT_PUBLISH_PROJECTS 
rem :::     for every runtime defined in DOT_PUBLISH_RUNTIMES
rem ::: 


if /i "%DOT_PUBLISH_PROJECTS%" equ "" echo No projects defined in %%DOT_PUBLISH_PROJECTS%%&exit /b 

::Configure nuget sources DOT_NUGET_SOURCES
call _dotnugets

:: Make sure we are in src folder
call _dotsrc
if %ERRORLEVEL% neq 0 exist /b 1


for %%S in ("%DOT_PUBLISH_PROJECTS:;=" "%") do if "%%S" neq "" call :publish_runtime %%S
goto :eof


:publish_runtime:
for %%R in ("%DOT_PUBLISH_RUNTIMES:;=" "%") do if "%%R" neq "" call :publish_project %1 %%R
goto :eof


:publish_project
echo Publishing %1 for runtime %2...

echo Running dotnet publish %1 %DOT_PUBLISH_ARGUMENTS% --runtime %2 %DOT_NUGET_SOURCES%
dotnet publish %1 %DOT_PUBLISH_ARGUMENTS% --runtime %2 %DOT_NUGET_SOURCES%
if %ERRORLEVEL% equ 0 echo %1 published successfully.
echo.
goto :eof


