@echo off
rem call dots to receive few variables
call .dots

set COMMAND_LIST=help addcon addlib addsln backup branch build clone commit develop diff dotnet dots feature foreach gitlab init master mirror newsln origin pack prerequisites publish restore status sync undo version release


echo Running local dots from current .\.dots folder

call :help_test 
for %%c in (%COMMAND_LIST%) do call :help_test %%c




echo Running global dots %USERPROFILE%\.dots folder

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
cd %TEST_DIR%


call :help_test 
for %%c in (%COMMAND_LIST%) do call :help_test %%c







goto exit


:help_test
SET COMMAND=%1
<nul set /p =Running .help %COMMAND%	
if "%1" equ "" ( call .help > %DOT_NUL% ) else ( call .help %COMMAND% > %DOT_NUL% )
if %ERRORLEVEL% neq 1 echo [ FAILED ] && echo Expected value is 1. Return value is %ERRORLEVEL% && exit 1 /b
echo [ OK ]
exit /b

:exit
cd %CURRENT_DIR_PATH%
rd /q %TEST_DIR%
