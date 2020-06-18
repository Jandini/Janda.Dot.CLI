@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git flow release
rem ::: 
rem ::: .RELEASE
rem ::: 
rem ::: Description: 
rem :::     Start new or finish git flow release in progress.
rem :::     A release branch is created. The first release version is always 1.0.0. The next would be 1.1.0 and so on.
rem :::     When the release is started he command offers to complete the release process automatically.
rem :::     The release process consist of finish and pack the libraries into nuget from master branch. 
rem ::: 

rem exit if not a git repository
if "%DOT_GIT_BRANCH%" equ "" exit


if /i "%DOT_GIT_BRANCH:~0,8%"=="release/" goto is_release_branch
if /i "%DOT_GIT_BRANCH%" neq "develop" echo You must start release from develop branch && goto end 

:is_release_branch

rem get file temp name from script name
set setver=%temp%\%~n0.cmd 

rem get current version
gitversion | jq -r "\"set DOT_GIT_VERSION=\"+ .MajorMinorPatch" > %setver%
call %setver%

rem adjust release version to 1.0.0
if "%DOT_GIT_VERSION%" equ "0.1.0" set DOT_GIT_VERSION=1.0.0


set NO_CONFIRM=N

if "%DOT_GIT_BRANCH:~0,8%"=="release/" goto finish

set /p CONFIRM=Do you want to start (finish and pack) release %DOT_GIT_VERSION% (Y/F/[N])?
if /i "%CONFIRM%" equ "F" goto start_noconfirm
if /i "%CONFIRM%" neq "Y" goto end
goto start

:start_noconfirm
set NO_CONFIRM=Y

:start
echo Starting release/%DOT_GIT_VERSION%
git flow release start %DOT_GIT_VERSION%
if %ERRORLEVEL% equ 1 echo Initializing... Run .release again when init is complete...&.init
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem get release branch name
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set DOT_GIT_BRANCH=%%F

:finish
if "%NO_CONFIRM%" equ "Y" goto release

set CONFIRM=N
set /p CONFIRM=Do you want to finish (and pack) the %DOT_GIT_BRANCH% now (Y/P/[N])?
if /i "%CONFIRM%" equ "P" goto release_noconfirm
if /i "%CONFIRM%" neq "Y" goto end
goto release

:release_noconfirm
set NO_CONFIRM=Y

:release
git flow release finish -m "Released on %DATE% %TIME% version "
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%


if "%NO_CONFIRM%" equ "Y" goto pack
set CONFIRM=N
set /p CONFIRM=Do you want to pack the %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto end

:pack
rem check if current branch is develop before checking out master
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set DOT_GIT_BRANCH=%%F
if /i "%DOT_GIT_BRANCH%" neq "develop" echo The develop branch is expected as current branch! && goto finish 
git checkout master
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%
call .pack
git checkout develop

:end