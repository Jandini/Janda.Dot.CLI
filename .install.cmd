@echo off

echo Synchronizing system time...
w32tm /resync
if %ERRORLEVEL% neq 0 echo Make sure your system time is synchronized. Some packages may not install if the system time is out of sync.&pause


echo Checking prerequisites...
call .prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$process = (Start-Process -Wait -PassThru -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0\.prerequisites.cmd\"' -Verb runAs); exit $process.ExitCode"
if %ERRORLEVEL% equ 350 echo Computer restart is required to complete prerequisites installation. & exit %ERRORLEVEL%
if %ERRORLEVEL% neq 0 echo Prerequisites are incomplete & exit %ERRORLEVEL%

:build

call :add_nuget_source "%USERPROFILE%\.nuget\local" nuget.local
call .pack


echo Installation complete.
goto :eof


:add_nuget_source
dotnet nuget list source | find "%~1" >nul
if %ERRORLEVEL% equ 0 goto :eof

echo Adding %~2 source "%~1"
dotnet nuget add source "%~1" -n nuget.local
goto :eof

