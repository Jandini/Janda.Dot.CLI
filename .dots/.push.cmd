@call _dots %~n0 %* --require-git

rem ::: Git push with tags
rem ::: 
rem ::: .PUSH
rem ::: 
rem ::: Description: 
rem :::     Run git push with tags. 
rem :::     git push --all --follow-tags
rem ::: 

if %ERRORLEVEL% equ 1 exit /b
git push --all --follow-tags



