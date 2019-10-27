@call _dots %~n0 "Initialize git flow repository" "[project name]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set PROJECT_NAME=%BASE_NAME%
if "%1" neq "" set PROJECT_NAME=%1

echo Initializing git flow for %PROJECT_NAME%...
git flow init -d
set ORIGIN_URL=unknown
if "%CID_GITLAB_URL%%CID_GITLAB_USER%" neq "" set ORIGIN_URL=%CID_GITLAB_URL%/%CID_GITLAB_USER%/%PROJECT_NAME%.git && echo Remote origin will be configured. Run ".gitlab" to setup gitlab and jenkins.  
echo Adding remote %ORIGIN_URL%
git remote add origin %ORIGIN_URL%
