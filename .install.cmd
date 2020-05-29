@echo off

echo Checking prerequisites...
call .prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$process = (Start-Process -Wait -PassThru -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0\.prerequisites.cmd\"' -Verb runAs); exit $process.ExitCode"
if %ERRORLEVEL% equ 350 echo Computer restart is required to complete prerequisites installation. & exit %ERRORLEVEL%
if %ERRORLEVEL% neq 0 echo Prerequisites are incomplete & exit %ERRORLEVEL%

:build
call .pack

echo Installation complete.
goto :eof



