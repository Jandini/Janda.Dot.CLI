@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git pull 
rem ::: 
rem ::: .PULL [--all]
rem ::: 
rem ::: Description: 
rem :::     Run git pull or git pull --all
rem ::: 

echo Running git pull %1
git pull %1
if %ERRORLEVEL% equ 0 exit /b 

echo Running git fetch
git fetch

echo Running git pull %1
git pull %1
if %ERRORLEVEL% equ 0 exit /b 

if "%DOT_GIT_BRANCH%" equ "" echo ERROR: %%DOT_GIT_BRANCH%% is not defined.&exit

echo Running git branch --set-upstream-to=origin/%DOT_GIT_BRANCH% %DOT_GIT_BRANCH% 
git branch --set-upstream-to=origin/%DOT_GIT_BRANCH% %DOT_GIT_BRANCH% 
if %ERRORLEVEL% neq 0 echo I am giving up...&exit /b 

echo Running git pull %1
git pull %1
if %ERRORLEVEL% neq 0 echo Pull failed.&exit /b 




