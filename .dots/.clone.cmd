@call _dots %~n0 "Clone git repository" "<.|project name>" "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set PROJECT_NAME=%BASE_NAME%
set PROJECT_DIR=.
if "%1" neq "." set PROJECT_NAME=%1
if "%1" equ "." goto get_origin

set PROJECT_DIR=
if exist %PROJECT_NAME% echo Directory %PROJECT_NAME% already exists. && goto exit 

:get_origin
set ORIGIN_URL=unknown
if "%CID_GITLAB_URL%%CID_GITLAB_USER%" neq "" set ORIGIN_URL=%CID_GITLAB_URL%/%CID_GITLAB_USER%/%PROJECT_NAME%.git && goto clone_repository
echo CID_GITLAB_URL and CID_GITLAB_USER are required.
goto exit

:clone_repository
echo Cloning %ORIGIN_URL%
git clone %ORIGIN_URL% %PROJECT_DIR%
if %ERRORLEVEL% neq 0 goto exit

if "%PROJECT_DIR%" neq "." cd %PROJECT_NAME%

git checkout develop
if %ERRORLEVEL% neq 0 goto exit

git flow init -d
if %ERRORLEVEL% neq 0 goto exit

git branch

:exit