@call _dots %~n0 "Rollback last git commit" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Rollback last git commit
rem ::: 


call .gitlog 1
echo Rolling back...
git reset --soft HEAD~1 2>nul
if %ERRORLEVEL% equ 1 echo Cannot rollback anymore... 
call .gitlog 2
call .status


