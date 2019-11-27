@call _dots %~n0 "Get current version and set DOT_GIT_VERSION variable (InformationalVersion is default)" "[InformationalVersion|AssemblySemFileVer|MajorMinorPatch...]" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" (set VERSION_NAME=InformationalVersion) else (set VERSION_NAME=%1)
echo Retrieving %VERSION_NAME%...
set setver=%temp%\_dot%RANDOM%version.cmd 
gitversion | jq -r "\"set DOT_GIT_VERSION=\"+ .%VERSION_NAME%" > %setver% 2>nul
if %ERRORLEVEL% neq 0 goto fixed_version
call %setver%
del /q %setver%
goto exit

:fixed_version
set DOT_GIT_VERSION=0.0.0

:exit
echo %VERSION_NAME% is %DOT_GIT_VERSION%