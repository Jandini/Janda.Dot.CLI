@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git branch status
rem ::: 
rem ::: .STATUS
rem ::: 
rem ::: Description: 
rem :::     Shows current git branch and status
rem ::: 


echo You are working on %DOT_GIT_BRANCH%
git branch
echo.
git status -sb
echo.
echo.
