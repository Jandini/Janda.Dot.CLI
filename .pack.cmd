@echo off

rem make sure that _* scripts are available during packing
set DOT_LOCAL_PATH=.\.dots\
set PATH | find "%LOCAL_DOTS%" > nul
if %ERRORLEVEL% neq 0 set PATH=%DOT_LOCAL_PATH%;%PATH%


echo Building dots package...

call .\.dots\_dots %~n0 "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .\.dots\.version > nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call :build_nuspec_file


rem by default output to bin within current folder
rem output can be overriden by setting OUTPUT_DIR variable
if "%OUTPUT_DIR%" equ "" set OUTPUT_DIR=bin


call :update_path "%%userprofile%%\.dots"



rem Add current dot version to template.config files
call :prepare_templates

set PACKAGE=%DOT_BASE_NAME%.%DOT_GIT_VERSION%.nupkg
echo %DOT_GIT_VERSION% > %DOT_LOCAL_PATH%.dotversion

echo Packing %PACKAGE%...
nuget pack .nuspec -OutputDirectory %OUTPUT_DIR% -NoDefaultExcludes -Version %DOT_GIT_VERSION% -Properties NoWarn=NU5105
if %ERRORLEVEL% neq 0 call :revert_templates %ERRORLEVEL% "Nuget pack failed."

echo Checking %PACKAGE% in %OUTPUT_DIR%...
if not exist %OUTPUT_DIR%\%PACKAGE% call :revert_templates -1 "Cannot find package %PACKAGE% in %OUTPUT_DIR%"

call :revert_templates


if "%1" equ "noinstall" goto :eof


echo Installing templates...
dotnet new -i %OUTPUT_DIR%\%PACKAGE% > nul
if %ERRORLEVEL% neq 0 echo "Installation failed."
echo Templates %DOT_GIT_VERSION% installed successfully.


if exist %DOT_PATH_GLOBAL% del /q %DOT_PATH_GLOBAL%\*.* 
if not exist %DOT_PATH_GLOBAL% mkdir %DOT_PATH_GLOBAL% 2>nul 

echo Copying dots to %DOT_PATH_GLOBAL% 
copy %DOT_PATH%\*.cmd %DOT_PATH_GLOBAL% > nul 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Adding .dotversion file...
echo %DOT_GIT_VERSION% > %DOT_PATH_GLOBAL%.dotversion
echo Build complete.
goto :eof


:revert_templates
if "%~2" neq "" echo %~2

rem echo Restoring templates...
for /f %%f in ('dir /b /s template.json') do if exist %%f.org move %%f.org %%f > nul
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
if "%1" neq "" exit %1
rem echo Templates reverted.
goto :eof


:prepare_templates
call :revert_templates
rem echo Preparing templates...
for /f %%f in ('dir /b /s template.json') do call :update_template %%f
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
rem echo Templates version set to %DOT_GIT_VERSION%
goto :eof


:update_template
move "%~1" "%~1.org" > nul 
type "%~1.org" | jq --arg version %DOT_GIT_VERSION% ".classifications += [$version]" > "%~1"
if %ERRORLEVEL% neq 0 call :revert_templates -1 "%~1"
goto :eof


:update_path
set INSTALL_PATH=%~1
set PATH | find "%INSTALL_PATH%" > nul
if %ERRORLEVEL% equ 0 goto :eof
echo Adding %INSTALL_PATH% to PATH environment
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "$path=[Environment]::GetEnvironmentVariable('path', 'user'); if (!$path.contains('%INSTALL_PATH%')) { $path+=';%INSTALL_PATH%'; [Environment]::SetEnvironmentVariable('path', $($path -join ';'), 'user'); }"
exit /b %ERRORLEVEL%


:build_nuspec_file

set NUSPEC_FILE=.nuspec
set NUSPEC_PACKAGE_VERSION=%DOT_GIT_VERSION%
set NUSPEC_PACKAGE_ID=Janda.Dot.CLI
set NUSPEC_PACKAGE_AUTHORS=Matt Janda
set NUSPEC_PACKAGE_DESCRIPTION=.NET Core templates and scripts
set NUSPEC_PACKAGE_TITLE=
set NUSPEC_PACKAGE_OWNERS=

call :nuspec_append_header
call :nuspec_append_content content %~p0
call :nuspec_append_dots .dots %~p0
call :nuspec_append_footer
echo The file %NUSPEC_FILE% created successfully.
goto :eof



:nuspec_append_header
echo Creating %NUSPEC_FILE% file...
echo ^<?xml version="1.0" encoding="utf-8"?^>> %NUSPEC_FILE%
echo ^<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd"^>>> %NUSPEC_FILE%
echo   ^<metadata^>>> %NUSPEC_FILE%
echo     ^<id^>%NUSPEC_PACKAGE_ID%^</id^>>> %NUSPEC_FILE%
echo     ^<version^>%NUSPEC_PACKAGE_VERSION%^</version^>>> %NUSPEC_FILE%
echo     ^<title^>%NUSPEC_PACKAGE_TITLE%^</title^>>> %NUSPEC_FILE%
echo     ^<authors^>%NUSPEC_PACKAGE_AUTHORS%^</authors^>>> %NUSPEC_FILE%
echo     ^<owners^>%NUSPEC_PACKAGE_OWNERS%^</owners^>>> %NUSPEC_FILE%
echo     ^<requireLicenseAcceptance^>false^</requireLicenseAcceptance^>>> %NUSPEC_FILE%
echo     ^<description^>%NUSPEC_PACKAGE_DESCRIPTION%^</description^>>> %NUSPEC_FILE%
echo   ^</metadata^>>> %NUSPEC_FILE%
echo   ^<files^>>> %NUSPEC_FILE%
goto :eof

:nuspec_append_footer
echo   ^</files^>>> %NUSPEC_FILE%
echo ^</package^>>> %NUSPEC_FILE%
goto :eof

:nuspec_append_content
echo Adding %~1 to %NUSPEC_FILE% file...
for /R "%~1" %%G in ("*.*") do if %%~nxG neq %~nx0 call :nuspec_append_file "%%~pG%%~nxG" "%~2"
goto :eof

:nuspec_append_dots
echo Adding %~1 to %NUSPEC_FILE% file...
for /R "%~1" %%G in ("*.cmd") do call :nuspec_append_file "%%~pG%%~nxG" "%~2.dots" .dots content\Dot.Scripts\.dots
echo     ^<file src=".dots\template.json" target="content\Dot.Scripts\.template.config\template.json" /^>>> %NUSPEC_FILE%
goto :eof


:nuspec_append_file
set CONTENT_PATH=%~1
set SEARCH_FOR=%~2
set REPLACE_TO=
call set CONTENT_PATH=%%CONTENT_PATH:%SEARCH_FOR%=%REPLACE_TO%%%
rem echo Adding %CONTENT_PATH%
echo     ^<file src="%~3%CONTENT_PATH%" target="%~4%CONTENT_PATH%" /^>>> %NUSPEC_FILE%
goto :eof

