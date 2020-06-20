@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git commit rollback
rem ::: 
rem ::: .ROLLBACK
rem ::: 
rem ::: Description: 
rem :::     Rollback previous git commit one by one. 
rem :::     git reset --soft HEAD~1
rem ::: 


call .gitlog 1
echo Rolling back...
git reset --soft HEAD~1 2>nul
if %ERRORLEVEL% equ 1 echo Cannot rollback anymore... 
call .gitlog 2
call .status


