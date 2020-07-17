@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git flow release
rem ::: 
rem ::: .RELEASE [--changelog [first]] [--version <version>]
rem ::: 
rem ::: Parameters: 
rem :::     changelog - optional switch to automatically update changelog while on release branch
rem :::     version - version bump
rem ::: 
rem ::: Description: 
rem :::     Start new or finish git flow release in progress. A release branch is created.
rem :::     When the release is started he command offers to complete the release process automatically.
rem :::     The release process consist of finish and pack the libraries into nuget from master branch. 
rem ::: 

rem this will make sure nested calls to dot scripts will not clear the args
set DOT_KEEP_ARGS=1

set CHANGELOG_ARGS=--silent --force
if /i "%DOT_ARG_CHANGELOG%" equ "first" set CHANGELOG_ARGS=%CHANGELOG_ARGS% --first

rem exit if not a git repository
if "%DOT_GIT_BRANCH%" equ "" exit


if /i "%DOT_GIT_BRANCH:~0,8%"=="release/" goto is_release_branch
if /i "%DOT_GIT_BRANCH%" neq "develop" echo You must start release from develop branch && goto end 

:is_release_branch

if not defined DOT_ARG_VERSION goto :git_version
echo Using provided version %DOT_ARG_VERSION%

set RELEASE_VERSION=%DOT_ARG_VERSION%
goto :skip_git_version

:git_version
echo Getting current version...
call .version MajorMinorPatch
set RELEASE_VERSION=%DOT_GIT_VERSION%

:skip_git_version
set CHANGELOG_ARGS=%CHANGELOG_ARGS% --version %RELEASE_VERSION%


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
if defined DOT_ARG_CHANGELOG call :changelog_update


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


:changelog_update
echo Updating CHANGELOG.md...
call .changelog %CHANGELOG_ARGS%
goto :eof


:changelog_preview
if not defined DOT_ARG_CHANGELOG goto :eof
echo Creating preview for CHANGELOG.md...
call .changelog --dry %CHANGELOG_ARGS%

rem make sure we remove dry argument because DOT_KEEP_ARGS is used 
set DOT_ARG_DRY=
goto :eof


