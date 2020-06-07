@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Use standard-version to generate change log
rem ::: 
rem ::: .CHANGELOG [append]
rem ::: 

set ARGS=--skip.tag --skip.commit --skip.bump
if "%~1" neq "append" set ARGS=--dry-run %ARGS%

standard-version %ARGS%

