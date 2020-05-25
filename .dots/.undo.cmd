@call _dots %~n0 "Undo or redo soft last commit" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .gitlog 1
echo Resetting...
git reset HEAD@{1}
call .gitlog 2
call .status


