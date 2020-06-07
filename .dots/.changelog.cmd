@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Use standard-version to generate change log
rem ::: 
rem ::: .CHANGELOG [dry]
rem ::: 


call .version MajorMinorPatch >nul

rem --skip.commit --skip.bump
set ARGS=--skip.tag --release-as %DOT_GIT_VERSION%
if "%~1" equ "dry" set ARGS=--dry-run %ARGS%

standard-version %ARGS%

