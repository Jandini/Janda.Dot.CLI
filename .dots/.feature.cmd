@call _dots %~n0 "Start new or finish current git flow feature" "[-c(heckout)|[-d(elete)] <feature-branch-name>" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem exit if not a git repository
if "%CURRENT_BRANCH%" equ "" exit

set PARAM_BRANCH=%1

:parameter_delete
rem parameter -d(elete) script block
if /i "%PARAM_BRANCH:~0,2%" neq "-d" goto parameter_checkout

rem allow to delte only feature branch
if "%CURRENT_BRANCH:~0,8%" neq "feature/" echo Branch %CURRENT_BRANCH% is not feature branch. && exit
rem confirm before deleting
set /p CONFIRM=WARNING: You are working on %CURRENT_BRANCH%. Do you want to [D]elete it (D/[N])?
if /i "%CONFIRM%" neq "D" goto script_end

echo Checking out develop branch			
git checkout develop
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%
echo Deleting %CURRENT_BRANCH% 
git branch -d %CURRENT_BRANCH%
goto script_end


:parameter_checkout
if /i "%PARAM_BRANCH:~0,2%" neq "-c" goto script_start

set CHECKOUT_BRANCH=%2
if "%CHECKOUT_BRANCH%" equ "" git branch && goto script_usage
if "%CHECKOUT_BRANCH:~0,8!" equ "feature/" goto branch_checkout 
set CHECKOUT_BRANCH=feature/%CHECKOUT_BRANCH%

:branch_checkout
echo Checking out %CHECKOUT_BRANCH%
git checkout %CHECKOUT_BRANCH%
goto script_end


:script_start

rem if we are on develop or master branch and the new feature branch name was not provided then end the script
if /i "%CURRENT_BRANCH%" equ "develop" (if "%PARAM_BRANCH%" equ "" (goto script_usage) else (goto feature_start)) 
if /i "%CURRENT_BRANCH%" equ "master" (if "%PARAM_BRANCH%" equ "" (goto script_usage) else (goto feature_start)) 

rem allow to switch feature branches
if "%CURRENT_BRANCH:~0,8%" equ "feature/" ( if "%PARAM_BRANCH%" neq "" goto feature_switch ) 

goto feature_finish

:feature_switch
rem make sure we don't switch without confirmation
set /P CONFIRM=WIP: You are working on %CURRENT_BRANCH%. Do you want to start new feature/%PARAM_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto script_end

:feature_start
echo Starting feature/%1
git flow feature start %PARAM_BRANCH%
goto script_end


:feature_finish
set /p CONFIRM=WIP: Do you want to finish the %CURRENT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto script_end
git flow feature finish
goto script_end


:script_usage
.help feature 

:script_end
exit %ERRORLEVEL%
