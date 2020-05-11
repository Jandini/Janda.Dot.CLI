@call _dots %~n0 "Undo git changes" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b
rem git reset HEAD~1
rem https://coderwall.com/p/e8oqzg/git-undo-git-reset

