@echo off

set DOT_POWERSHELL_CMD="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command


echo Checking prerequisites...
call .prerequisites check
if %ERRORLEVEL% equ 0 goto build

echo Installing prerequisites...
%DOT_POWERSHELL_CMD% "$process = (Start-Process -Wait -PassThru -FilePath 'cmd.exe' -ArgumentList '/c \"%~dp0\.prerequisites.cmd\"' -Verb runAs); exit $process.ExitCode"
if %ERRORLEVEL% equ 350 echo Computer restart is required to complete prerequisites installation. & exit %ERRORLEVEL%
if %ERRORLEVEL% neq 0 echo Prerequisites are incomplete. Re-open command prompt and try again. & exit %ERRORLEVEL%
call RefreshEnv
:build

call :add_dots_path "%%userprofile%%\.dots"
call :add_nuget_source "%USERPROFILE%\.nuget\local" nuget.local

git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% equ 0 (call .pack) else (call .clone)
echo Installation complete.
goto :eof


:add_nuget_source
dotnet nuget list source | find "%~1" >nul
if %ERRORLEVEL% equ 0 goto :eof

echo Adding %~2 source "%~1"
dotnet nuget add source "%~1" -n nuget.local
goto :eof


:add_dots_path
set INSTALL_PATH=%~1
set PATH | find "%INSTALL_PATH%" > nul
if %ERRORLEVEL% equ 0 goto :eof
echo Adding %INSTALL_PATH% to PATH environment
%DOT_POWERSHELL_CMD% "$path=[Environment]::GetEnvironmentVariable('path', 'user'); if (!$path.contains('%INSTALL_PATH%')) { $path+=';%INSTALL_PATH%'; [Environment]::SetEnvironmentVariable('path', $($path -join ';'), 'user'); }"
exit /b %ERRORLEVEL%
