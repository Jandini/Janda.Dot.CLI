@echo off
call .dots

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
pushd %TEST_DIR%

echo Running .newdot Test.Solution
call .newdot Test.Solution
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

echo Running .addcon .Application
call .addcon .Application
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

call .build
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

cd ..
rd /q /s Test.Solution

 
popd 

cd %DOT_CURRENT_DIR_PATH%
if "%TEST_DIR%" neq "" rd /q %TEST_DIR%
