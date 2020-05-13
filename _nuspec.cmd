@echo off
set OUTPUT=.nuspec
call .\.dots\.version

call :append_header
call :append_files content %~p0
call :append_files .dots %~p0.dots .dots content\DotScripts\.dots
call :append_footer
goto :eof


:append_header
echo Creating %OUTPUT%
echo ^<?xml version="1.0" encoding="utf-8"?^>> %OUTPUT%
echo ^<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd"^>>> %OUTPUT%
echo   ^<metadata^>>> %OUTPUT%
echo     ^<id^>dots-cli^</id^>>> %OUTPUT%
echo     ^<version^>%DOT_GIT_VERSION%^</version^>>> %OUTPUT%
echo     ^<title^>^</title^>>> %OUTPUT%
echo     ^<authors^>Matt Janda^</authors^>>> %OUTPUT%
echo     ^<owners^>^</owners^>>> %OUTPUT%
echo     ^<requireLicenseAcceptance^>false^</requireLicenseAcceptance^>>> %OUTPUT%
echo     ^<description^>.NET Core templates and scripts^</description^>>> %OUTPUT%
echo   ^</metadata^>>> %OUTPUT%
echo   ^<files^>>> %OUTPUT%
goto :eof

:append_footer
echo   ^</files^>>> %OUTPUT%
echo ^</package^>>> %OUTPUT%
goto :eof

:append_files
echo Adding %~1 to %OUTPUT%
for /R "%~1" %%G in ("*.*") do if %%~nxG neq %~nx0 call :append_file "%%~pG%%~nxG" "%~2" %3 %4
goto :eof

:append_file
set CONTENT_PATH=%~1
set SEARCH_FOR=%~2
set REPLACE_TO=
call set CONTENT_PATH=%%CONTENT_PATH:%SEARCH_FOR%=%REPLACE_TO%%%
rem echo Adding %CONTENT_PATH%
echo     ^<file src="%~3%CONTENT_PATH%" target="%~4%CONTENT_PATH%" /^>>> %OUTPUT%
goto :eof

