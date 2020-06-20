@echo off
call .dots

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
pushd %TEST_DIR%

echo --- Creating new repository Test.Solution
call .newdot Test.Solution
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

echo --- Adding console application "Tool"
call .addcon Tool
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

echo --- Adding .Application
call .addcon .Application
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b


echo --- Building soltuion 
call .build
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b


echo --- Try build without default solution file
del Test.Solution.sln
call .build 
if %ERRORLEVEL% neq 1 echo [ FAILED ] && echo Expected value is 1. Return value is %ERRORLEVEL% && exit 1 /b

cd ..
rd /q /s Test.Solution

 
popd 

cd %DOT_CURRENT_DIR_PATH%
if "%TEST_DIR%" neq "" rd /q %TEST_DIR%
