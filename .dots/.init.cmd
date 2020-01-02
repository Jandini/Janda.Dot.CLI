@call _dots %~n0 "Initialize git flow repository" "[project name]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set PROJECT_NAME=%DOT_BASE_NAME%
if "%1" neq "" set PROJECT_NAME=%1

echo Initializing git flow for %PROJECT_NAME%...
git flow init -d
if %ERRORLEVEL% equ 0 goto origin

set /p CONFIRM=WARNING: Do you want to stash your changes and try again ? (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto exit

echo Stashing your changes...
git stash
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo Initializing git flow again...
git flow init -d
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo Restoring your changes...
git stash pop
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:origin
set ORIGIN_URL=unknown
if "%CID_GITLAB_URL%%CID_GITLAB_USER%" neq "" set ORIGIN_URL=%CID_GITLAB_URL%/%CID_GITLAB_USER%/%PROJECT_NAME%.git && echo Remote origin will be configured. Run ".gitlab" to setup gitlab and jenkins.  
echo Adding remote %ORIGIN_URL%
git remote add origin %ORIGIN_URL%


:exit