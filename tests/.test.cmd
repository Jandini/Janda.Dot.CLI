@echo off
rem call dots to receive few variables
call .dots

set COMMAND_LIST=help addcon addlib addsln backup branch build clone commit develop diff dotnet dots feature foreach gitlab init master mirror newsln origin pack prerequisites publish restore status sync undo version release


echo Running local dots from current .\.dots folder



rem call :test_command version
rem call :test_command branch

call :test_help 
for %%c in (%COMMAND_LIST%) do call :test_help %%c



echo Running global dots %USERPROFILE%\.dots folder

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
pushd %TEST_DIR%


call :test_command version 1
call :test_command branch 1


rem help must work everywhere
call :test_help 
for %%c in (%COMMAND_LIST%) do call :test_help %%c

popd 


goto exit



:test_command
set COMMAND=.%1
set EXPECTED=%2
if "%EXPECTED%" equ "" set EXPECTED=0
<nul set /p =Running %COMMAND%	
call %COMMAND% > %DOT_NUL% 
if %ERRORLEVEL% neq %EXPECTED% echo [ FAILED ] && echo Expected value is %EXPECTED%. Return value is %ERRORLEVEL% && exit 1 /b
echo [ OK ]
exit /b



:test_help
set COMMAND=%1
<nul set /p =Running .help %COMMAND%	
if "%1" equ "" ( call .help > %DOT_NUL% ) else ( call .help %COMMAND% > %DOT_NUL% )
if %ERRORLEVEL% neq 1 echo [ FAILED ] && echo Expected value is 1. Return value is %ERRORLEVEL% && exit 1 /b
echo [ OK ]
exit /b

:exit
cd %CURRENT_DIR_PATH%
rd /q %TEST_DIR%
