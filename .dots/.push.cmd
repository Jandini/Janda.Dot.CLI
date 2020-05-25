@call _dots %~n0 "Run git push" " g" %1 %2 %3

rem ::: Run git push with follow tags
rem ::: 

if %ERRORLEVEL% equ 1 exit /b
git push --all --follow-tags



