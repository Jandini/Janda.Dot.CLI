@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Get current version and set DOT_GIT_VERSION variable (InformationalVersion is default)
rem ::: 
rem ::: .VERSION [InformationalVersion|AssemblySemFileVer|MajorMinorPatch...]
rem ::: 


if "%1" equ "" (set VERSION_NAME=InformationalVersion) else (set VERSION_NAME=%1)
call :get_version %VERSION_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo %DOT_GIT_VERSION%
goto :eof


:get_version
set DOT_GIT_VERSION=
for /f %%i in ('gitversion /showvariable %1') do set DOT_GIT_VERSION=%%i
if "%DOT_GIT_VERSION%" neq "" goto :eof
where gitversion 2>nul
if %ERRORLEVEL% equ 0 (set DOT_GIT_VERSION=0.0.0) else (exit /b %ERRORLEVEL%)
goto :eof
