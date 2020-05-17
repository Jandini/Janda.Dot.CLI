@call _dots %~n0 "Synchronize repository" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

git fetch --all
if %ERRORLEVEL% neq 0 goto :eof

set BRANCH_FILE=%TEMP%\%RANDOM%.gitsync
git for-each-ref --format="%%(refname:short) %%(push:track)" refs/heads > %BRANCH_FILE% 

set SYNC_REQUIRED=FALSE
for /F "tokens=1,2 delims=[" %%A in (%BRANCH_FILE%) do if "%%B" neq "" echo %DOT_BASE_NAME%/%%A && set SYNC_REQUIRED=TRUE
del %BRANCH_FILE% 2>nul

if "%SYNC_REQUIRED%" equ "FALSE" echo Nothing to synchronize & goto :eof
call .mirror
