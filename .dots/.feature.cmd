@call _dots %~n0 "Start new or checkout existing feature. Finish current feature. Update current feature from develop branch. Delete current feature." "[-u(pdate)|[-d(elete)] <[feature-branch-name]>" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem exit if not a git repository
if "%DOT_GIT_BRANCH%" equ "" exit /b

set PARAM_BRANCH=%1

:parameter_delete
rem parameter -d(elete) script block
if /i "%PARAM_BRANCH:~0,2%" neq "-d" goto parameter_update

rem allow to delete only feature branch
if "%DOT_GIT_BRANCH:~0,8%" neq "feature/" echo Branch %DOT_GIT_BRANCH% is not feature branch. && exit /b
rem confirm before deleting
set /p CONFIRM=WARNING: You are working on %DOT_GIT_BRANCH%. Do you want to [D]elete it (D/[N])?
if /i "%CONFIRM%" neq "D" goto script_end

echo Checking out develop branch...
git checkout develop
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Deleting %DOT_GIT_BRANCH% 
git branch -d %DOT_GIT_BRANCH%
goto script_end


:parameter_update
if /i "%PARAM_BRANCH:~0,2%" neq "-u" goto script_start
if "%DOT_GIT_BRANCH:~0,8%" neq "feature/" echo Branch %DOT_GIT_BRANCH% is not feature branch. && exit /b
set /p CONFIRM=WARNING: You are working on %DOT_GIT_BRANCH%. Do you want to [U]pdate it from develop branch (U/[N])?
if /i "%CONFIRM%" neq "U" goto script_end
git merge develop 
goto script_end



:script_start
rem if we are on develop or master branch and the new feature branch name was not provided then end the script
if /i "%DOT_GIT_BRANCH%" equ "develop" (if "%PARAM_BRANCH%" equ "" (goto script_usage) else (goto feature_start)) 
if /i "%DOT_GIT_BRANCH%" equ "master" (if "%PARAM_BRANCH%" equ "" (goto script_usage) else (goto feature_start)) 

rem allow to switch feature branches
if "%DOT_GIT_BRANCH:~0,8%" equ "feature/" ( if "%PARAM_BRANCH%" neq "" goto feature_switch ) 

goto feature_finish

:feature_switch
rem make sure we don't switch without confirmation
set /P CONFIRM=WIP: You are working on %DOT_GIT_BRANCH%. Do you want to start new feature/%PARAM_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto script_end


:feature_start
set CHECKOUT_BRANCH=feature/%PARAM_BRANCH%
git checkout %CHECKOUT_BRANCH% 2>nul
if %ERRORLEVEL% equ 0 echo Checkout existing %CHECKOUT_BRANCH% completed successfully.&& goto script_end
echo Starting feature/%1
git flow feature start %PARAM_BRANCH%
goto script_end


:feature_finish
set /p CONFIRM=WIP: Do you want to finish the %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto script_end
git flow feature finish
goto script_end


:script_usage
call .help feature 
echo.
git branch | grep feature/


:script_end
exit /b %ERRORLEVEL%
