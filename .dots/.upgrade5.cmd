@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run upgrade assistant
rem ::: 
rem ::: .UPGRADE
rem ::: 
rem ::: Description: 
rem :::     .NET5 upgrade assistant
rem ::: 

set PROJECT_FILE=
for /f %%i in ('dir *.csproj /b') do set PROJECT_FILE=%%i

echo Running upgrade-assistant upgrade --skip-backup --non-interactive %PROJECT_FILE%
upgrade-assistant upgrade --skip-backup --non-interactive %PROJECT_FILE%

