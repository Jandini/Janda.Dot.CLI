for %%I in (.) do set CURRENT_DIR_NAME=%%~nxI
if "%CURRENT_DIR_NAME%" equ "src" goto :eof

cd src 2>nul
if %ERRORLEVEL% neq 0 echo The src directory was not found.&exit /b %ERRORLEVEL%

