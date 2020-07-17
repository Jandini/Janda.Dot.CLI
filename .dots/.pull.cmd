@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git pull 
rem ::: 
rem ::: .PULL
rem ::: 
rem ::: Description: 
rem :::     Run git pull 
rem ::: 

git pull



