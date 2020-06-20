@echo off
call .dots

set TEST_DIR=%TEMP%\T%RANDOM%
mkdir %TEST_DIR%
pushd %TEST_DIR%

rem wip: clone mirror sync undo
set COMMAND_LIST=addcon addsln backup branch build commit diff dotnet feature foreach gitlab help init newdot gitorigin pack publish release restore status version
set DOTS_LIST=_dots _dothelp


echo Running dotnet new dots
dotnet new dots > %DOT_OUT%
if %ERRORLEVEL% neq 0 echo [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

for %%c in (%DOTS_LIST%) do call :command_exist %%c
for %%c in (%COMMAND_LIST%) do call :command_exist .%%c


rd /q /s .dots

 
popd 

call :cleanup

goto :eof



:command_exist
set COMMAND=.dots\%1.cmd
<nul set /p =Checking %COMMAND%	
if not exist %COMMAND% echo [ FAILED ] && echo %COMMAND% does not exist && exit 1 /b
echo [ OK ]
goto :eof


:cleanup
cd %DOT_CURRENT_DIR_PATH%
if "%TEST_DIR%" neq "" rd /q %TEST_DIR%
goto :eof