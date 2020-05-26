@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Undo or redo soft last commit
rem ::: 
rem ::: .UNDO
rem ::: 


call .gitlog 1
echo Undoing...
git reset HEAD@{1}
call .gitlog 2
call .status


