@echo off

echo Checking prerequisites...
call .prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$process = (Start-Process -Wait -PassThru -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0\.prerequisites.cmd\"' -Verb runAs); exit $process.ExitCode"
if %ERRORLEVEL% equ 350 echo Computer restart is required to complete prerequisites installation. & exit %ERRORLEVEL%
if %ERRORLEVEL% neq 0 echo Prerequisites are incomplete. Re-open command prompt and try again. & exit %ERRORLEVEL%
call RefreshEnv
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

