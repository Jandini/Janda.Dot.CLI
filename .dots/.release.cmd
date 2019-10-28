@call _dots %~n0 "Start new or finish git flow release in progress" "" " g" %1 %2 %3
rem :.release is parameterless
rem :Start new or finish git flow release in progress. 
if %ERRORLEVEL% equ 1 exit /b

rem exit if not a git repository
if "%CURRENT_BRANCH%" equ "" exit


if /i "%CURRENT_BRANCH:~0,8%"=="release/" goto is_release_branch
if /i "%CURRENT_BRANCH%" neq "develop" echo You must start release from develop branch && goto end 

:is_release_branch

rem get file temp name from script name
set setver=%temp%\%~n0.cmd 

rem get current version
gitversion | jq -r "\"set VERSION=\"+ .MajorMinorPatch" > %setver%
call %setver%

rem adjust release version to 1.0.0
if "%VERSION%" equ "0.1.0" set VERSION=1.0.0


set NO_CONFIRM=N

if "%CURRENT_BRANCH:~0,8%"=="release/" goto finish

set /p CONFIRM=Do you want to start (finish and pack) release %VERSION% (Y/F/[N])?
if /i "%CONFIRM%" equ "F" goto start_noconfirm
if /i "%CONFIRM%" neq "Y" goto end
goto start

:start_noconfirm
set NO_CONFIRM=Y

:start
echo Starting release/%VERSION%
git flow release start %VERSION%
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

rem get release branch name
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set CURRENT_BRANCH=%%F

:finish
if "%NO_CONFIRM%" equ "Y" goto release

set CONFIRM=N
set /p CONFIRM=Do you want to finish (and pack) the %CURRENT_BRANCH% now (Y/P/[N])?
if /i "%CONFIRM%" equ "P" goto release_noconfirm
if /i "%CONFIRM%" neq "Y" goto end
goto release

:release_noconfirm
set NO_CONFIRM=Y

:release
git flow release finish -m "%VERSION%"
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%


if "%NO_CONFIRM%" equ "Y" goto pack
set CONFIRM=N
set /p CONFIRM=Do you want to pack the %CURRENT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto end

:pack
rem check if current branch is develop before checking out master
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set CURRENT_BRANCH=%%F
if /i "%CURRENT_BRANCH%" neq "develop" echo The develop branch is expected as current branch! && goto finish 
git checkout master
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%
call .pack
git checkout develop

:end