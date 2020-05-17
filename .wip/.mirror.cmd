@call _dots %~n0 "Synchronize with remote git repository" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

echo Fetching branches...
git fetch --all
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Fetching tags...
git fetch --tags
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Pulling branches...
git pull --all
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Pulling tags...
git pull --tags
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Pushing branches...
git push --all
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Pushing tags...
git push --tags
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

echo Pruning branches...
git remote prune origin