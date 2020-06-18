cd src 2>nul
if %ERRORLEVEL% neq 0 echo The src directory was not found.&exit /b %ERRORLEVEL%

