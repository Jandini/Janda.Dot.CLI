@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Get current version and set DOT_GIT_VERSION variable (InformationalVersion is default)
rem ::: 
rem ::: .VERSION [InformationalVersion|AssemblySemFileVer|MajorMinorPatch...]
rem ::: 


if defined DOT_GIT_VERSION goto :eof

if "%1" equ "" (set VERSION_NAME=InformationalVersion) else (set VERSION_NAME=%1)
echo Retrieving %VERSION_NAME%...
call :get_version %VERSION_NAME%

echo %VERSION_NAME% is %DOT_GIT_VERSION%
goto :eof



:get_version
set DOT_GIT_VERSION=0.0.0
for /f %%i in ('gitversion /showvariable %1') do set DOT_GIT_VERSION=%%i
goto :eof
