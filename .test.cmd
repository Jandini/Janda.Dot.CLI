@echo off

call .pack

for /f %%f in ('dir /b tests\*.cmd') do call tests\%%f 

echo.
echo Tests completed successfully.