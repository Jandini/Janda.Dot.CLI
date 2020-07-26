@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git pull 
rem ::: 
rem ::: .PULL
rem ::: 
rem ::: Description: 
rem :::     Run git pull 
rem ::: 

echo Pulling...
git pull
if %ERRORLEVEL% equ 0 exit /b 

echo Fetching...
git fetch

echo Pulling again... 
git pull
if %ERRORLEVEL% equ 0 exit /b 

echo Trying to add tracking to %DOT_GIT_BRANCH% branch 
git branch --set-upstream-to=origin/%DOT_GIT_BRANCH% %DOT_GIT_BRANCH% 
if %ERRORLEVEL% neq 0 echo I am giving up...&exit /b 

echo Fetching...
git fetch

echo Pulling... 
git pull
if %ERRORLEVEL% neq 0 echo Pull failed.&exit /b 




