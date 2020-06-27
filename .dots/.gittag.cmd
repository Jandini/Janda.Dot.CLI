@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git tag
rem ::: 
rem ::: .GITTAG 
rem ::: 
rem ::: Description: 
rem :::     Show git tags
rem ::: 

git log --oneline --decorate --tags --no-walk


