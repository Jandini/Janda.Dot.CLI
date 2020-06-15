@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Start new or checkout existing feature. Finish current feature. Update current feature from develop branch. Delete current feature.
rem ::: 
rem ::: .FEATURE [feature-branch-name] [--update|--delete]
rem ::: 

@call _dotargs %*
set FEATURE_BRANCH_NAME=%DOT_ARG_DEFAULT%


if /i "%DOT_GIT_BRANCH:~0,8%" equ "feature/" call :on_feature_branch&exit /b %ERRORLEVEL%
if /i "%DOT_GIT_BRANCH%" equ "develop" call :on_non_feature_branch&exit /b %ERRORLEVEL%
if /i "%DOT_GIT_BRANCH%" equ "master" call :on_non_feature_branch&exit /b %ERRORLEVEL%

goto :eof



:on_feature_branch
if defined DOT_ARG_UPDATE call :update_branch&exit /b %ERRORLEVEL%
if defined DOT_ARG_DELETE call :delete_branch&exit /b %ERRORLEVEL%

if "%FEATURE_BRANCH_NAME%" equ "" call :finish_feature&exit /b %ERRORLEVEL%


set /P CONFIRM=WIP: You are working on %DOT_GIT_BRANCH%. Do you want to start new feature/%FEATURE_BRANCH_NAME% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof
call :start_feature %FEATURE_BRANCH_NAME%
exit /b %ERRORLEVEL%



:on_non_feature_branch
if "%FEATURE_BRANCH_NAME%" equ "" (call :script_usage) else (call :start_feature "%FEATURE_BRANCH_NAME%")
exit /b %ERRORLEVEL%




:start_feature 
git checkout feature/%FEATURE_BRANCH_NAME% 2>nul
if %ERRORLEVEL% equ 0 echo The feature branch was found. You are now working on feature/%FEATURE_BRANCH_NAME%.&goto :eof
echo Starting feature/%~1
git flow feature start %~1
goto :eof


:finish_feature
set /p CONFIRM=WIP: Do you want to finish the %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof
git flow feature finish
goto :eof



:update_branch
call :ensure_feature_branch
if %ERRORLEVEL% neq 0 goto :eof

set /p CONFIRM=WARNING: You are working on %DOT_GIT_BRANCH%. Do you want to [U]pdate it from develop branch (U/[N])?
if /i "%CONFIRM%" neq "U" goto :eof
git merge develop 
goto :eof


:delete_branch
rem delete only current feature branch
call :ensure_feature_branch
if %ERRORLEVEL% neq 0 goto :eof

rem confirm before deleting
set /p CONFIRM=WARNING: You are working on %DOT_GIT_BRANCH%. Do you want to [D]elete it (D/[N])?
if /i "%CONFIRM%" neq "D" goto :eof

echo Checking out develop branch...
git checkout develop
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
echo Deleting %DOT_GIT_BRANCH% 
git branch -d %DOT_GIT_BRANCH%
goto :eof


:ensure_feature_branch
if "%DOT_GIT_BRANCH:~0,8%" neq "feature/" echo Branch %DOT_GIT_BRANCH% is not feature branch.&exit /b 1
goto :eof


:script_usage
call .help feature 
echo.
git branch | findstr feature/
exit 0
