@echo off
call .dots

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
pushd %TEST_DIR%

echo Running .newcon Test .Application
call .newcon Janda.Test .Application
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

cd ..
rd /q /s Janda.Test

 
popd 

cd %DOT_CURRENT_DIR_PATH%
if "%TEST_DIR%" neq "" rd /q %TEST_DIR%
