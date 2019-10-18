@echo off
if "%1" equ "" exit /b 0
if exist ..\..\.dotset for /F "tokens=*" %%A in (..\..\.dotset) do set %%A
if "%BUILD_SLN%" equ "" for %%I in (..\..) do set BUILD_SLN=%%~nI%%~xI
for %%S in ("%BUILD_SLN:;=" "%") do if "%%S" neq "" call %1 %%S && if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
