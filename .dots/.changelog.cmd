@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots changelog
rem ::: 
rem ::: .CHANGELOG [--dry] [--silent] [--force] [--first]
rem ::: 
rem ::: Parameters: 
rem :::     dry - dry run to show the actions and the change log
rem :::     silent - pass it to standard version 
rem :::     force - supprerss user confirmation
rem :::     first - all features will be listed under current version
rem ::: 
rem ::: Description: 
rem :::     Automatically update CHANGELOG.md file based on conventional commits. 
rem :::     Use standard-version to generate change log file. 
rem :::     It will generate log since the last chore(release): x.x.x commit. 
rem :::     The generated log is automatically inserted into exisiting CHANGELOG.md or new is created. 
rem :::     The change is commited with chore(release): y.y.y comment.
rem :::     This command can be executed after the release is started.
rem ::: 

set DOT_KEEP_ARGS=1
call .version MajorMinorPatch >nul

rem --tag-prefix "" so the version tags can go without "v" letter
rem --skip.commit --skip.bump
set ARGS=--skip.tag --release-as %DOT_GIT_VERSION% 

if defined DOT_ARG_SILENT set ARGS=%ARGS% --silent
if defined DOT_ARG_FIRST set ARGS=%ARGS% --first-release
if not defined DOT_ARG_FIRST set ARGS=%ARGS% --tag-prefix ""

if defined DOT_ARG_DRY goto :dry
if defined DOT_ARG_FORCE goto :run

call :dry
set /P CONFIRM=Do you want to update CHANGELOG.md now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof


:run
call standard-version %ARGS%
goto :eof


:dry
call standard-version %ARGS% --dry-run

goto :eof

