@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git flow release
rem ::: 
rem ::: .RELEASE [--changelog]
rem ::: 
rem ::: Parameters: 
rem :::     changelog - Optional switch to automatically update changelog while on release branch
rem ::: 
rem ::: Description: 
rem :::     Start new or finish git flow release in progress.
rem :::     A release branch is created. The first release version is always 1.0.0. The next would be 1.1.0 and so on.
rem :::     When the release is started he command offers to complete the release process automatically.
rem :::     The release process consist of finish and pack the libraries into nuget from master branch. 
rem ::: 

rem this will make sure nested calls to dot scripts will not clear the args
set DOT_KEEP_ARGS=1

rem exit if not a git repository
if "%DOT_GIT_BRANCH%" equ "" exit


if /i "%DOT_GIT_BRANCH:~0,8%"=="release/" goto is_release_branch
if /i "%DOT_GIT_BRANCH%" neq "develop" echo You must start release from develop branch && goto end 

:is_release_branch


echo Getting current version...
call .version MajorMinorPatch
set RELEASE_VERSION=%DOT_GIT_VERSION%

rem adjust release version to 1.0.0 
rem this should be removed if version 0.x.0 are to be supported
if "%RELEASE_VERSION:~0,1%" neq "0" goto skip_bump

echo Bumping version to 1.0.0
set RELEASE_VERSION=1.0.0

:skip_bump

set NO_CONFIRM=N

if "%DOT_GIT_BRANCH:~0,8%"=="release/" goto finish

call :changelog_preview

set /p CONFIRM=Do you want to start (finish and pack) release %RELEASE_VERSION% (Y/F/[N])?
if /i "%CONFIRM%" equ "F" goto start_noconfirm
if /i "%CONFIRM%" neq "Y" goto :eof
goto start

:start_noconfirm
set NO_CONFIRM=Y

:start
echo Starting release/%RELEASE_VERSION%
git flow release start %RELEASE_VERSION%
if %ERRORLEVEL% equ 1 echo Initializing... Run .release again when init is complete...&.init
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem get release branch name
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set DOT_GIT_BRANCH=%%F

:finish
if "%NO_CONFIRM%" equ "Y" goto release

call :changelog_preview

set CONFIRM=N
set /p CONFIRM=Do you want to finish (and pack) the %DOT_GIT_BRANCH% now (Y/P/[N])?
if /i "%CONFIRM%" equ "P" goto release_noconfirm
if /i "%CONFIRM%" neq "Y" goto end
goto release

:release_noconfirm
set NO_CONFIRM=Y

:release
if defined DOT_ARG_CHANGELOG call .changelog

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
goto :eof


:changelog_preview
if not defined DOT_ARG_CHANGELOG goto :eof
echo Creating preview for CHANGELOG.md...
call .changelog dry
goto :eof


