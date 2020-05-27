@echo off
set OUTPUT=.nuspec
set PACKAGE_ID=Janda.Dots.CLI
set PACKAGE_AUTHORS=Matt Janda
set PACKAGE_DESCRIPTION=.NET Core templates and scripts
set PACKAGE_TITLE=
set PACKAGE_OWNERS=

call .\.dots\.version >nul
call :append_header
call :append_content content %~p0
call :append_dots .dots %~p0
call :append_footer
echo The file %OUTPUT% created successfully.
goto :eof


:append_header
echo Creating %OUTPUT% file...
echo ^<?xml version="1.0" encoding="utf-8"?^>> %OUTPUT%
echo ^<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd"^>>> %OUTPUT%
echo   ^<metadata^>>> %OUTPUT%
echo     ^<id^>%PACKAGE_ID%^</id^>>> %OUTPUT%
echo     ^<version^>%DOT_GIT_VERSION%^</version^>>> %OUTPUT%
echo     ^<title^>%PACKAGE_TITLE%^</title^>>> %OUTPUT%
echo     ^<authors^>%PACKAGE_AUTHORS%^</authors^>>> %OUTPUT%
echo     ^<owners^>%PACKAGE_OWNERS%^</owners^>>> %OUTPUT%
echo     ^<requireLicenseAcceptance^>false^</requireLicenseAcceptance^>>> %OUTPUT%
echo     ^<description^>%PACKAGE_DESCRIPTION%^</description^>>> %OUTPUT%
echo   ^</metadata^>>> %OUTPUT%
echo   ^<files^>>> %OUTPUT%
goto :eof

:append_footer
echo   ^</files^>>> %OUTPUT%
echo ^</package^>>> %OUTPUT%
goto :eof

:append_content
echo Adding %~1 to %OUTPUT% file...
for /R "%~1" %%G in ("*.*") do if %%~nxG neq %~nx0 call :append_file "%%~pG%%~nxG" "%~2"
goto :eof

:append_dots
echo Adding %~1 to %OUTPUT% file...
for /R "%~1" %%G in ("*.cmd") do if %%~nxG neq %~nx0 call :append_file "%%~pG%%~nxG" "%~2.dots" .dots content\Dot.Scripts\.dots
echo     ^<file src=".dots\template.json" target="content\Dot.Scripts\.template.config\template.json" /^>>> %OUTPUT%
goto :eof


:append_file
set CONTENT_PATH=%~1
set SEARCH_FOR=%~2
set REPLACE_TO=
call set CONTENT_PATH=%%CONTENT_PATH:%SEARCH_FOR%=%REPLACE_TO%%%
rem echo Adding %CONTENT_PATH%
echo     ^<file src="%~3%CONTENT_PATH%" target="%~4%CONTENT_PATH%" /^>>> %OUTPUT%
goto :eof
