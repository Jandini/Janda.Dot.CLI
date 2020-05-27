@echo off

echo Checking prerequisites...
call _prerequisites check
if %ERRORLEVEL% neq 0 start /wait "Installing prerequisites..." "cmd /c \"%~dp0\_prerequisites.cmd\""

echo Building dots package...
call .pack

echo Installation complete
goto :eof

