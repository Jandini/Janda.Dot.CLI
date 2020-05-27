@echo off

echo Checking prerequisites...
call _prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
call _prerequisites
echo Run this script again.
exit 

:build
echo Building dots package...
call .pack

echo Installation complete
goto :eof

