@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git soft reset
rem ::: 
rem ::: .UNDO
rem ::: 
rem ::: Description: 
rem :::     Undo or redo of the last commit.
rem ::: 


call .gitlog 1
echo Undoing...
git reset HEAD@{1}
call .gitlog 2
call .status


