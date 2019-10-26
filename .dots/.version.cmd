@call _dots %~n0 "Get current version and set VERSION variable (InformationalVersion is default)" "[InformationalVersion|AssemblySemFileVer|MajorMinorPatch...]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" (set GIT_VERSION=InformationalVersion) else (set GIT_VERSION=%1)
echo Retrieving %GIT_VERSION%
set setver=%temp%\_dot%RANDOM%version.cmd 
gitversion | jq -r "\"set VERSION=\"+ .%GIT_VERSION%" > %setver% 2>nul
if %ERRORLEVEL% neq 0 goto fixed_version
call %setver%
echo %setver%
del /q %setver%
goto exit

:fixed_version
set VERSION=1.0.0

:exit
echo %GIT_VERSION% is %VERSION%