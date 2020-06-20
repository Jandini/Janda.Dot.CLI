@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots changelog
rem ::: 
rem ::: .CHANGELOG [dry]
rem ::: 
rem ::: Parameters: 
rem :::     dry - dry run to show the actions and the change log
rem ::: 
rem ::: Description: 
rem :::     Automatically update CHANGELOG.md file based on conventional commits. 
rem :::     Use standard-version to generate change log file. 
rem :::     It will generate log since the last chore(release): x.x.x commit. 
rem :::     The generated log is automatically inserted into exisiting CHANGELOG.md or new is created. 
rem :::     The change is commited with chore(release): y.y.y comment.
rem :::     This command can be executed after the release is started.
rem ::: 


call .version MajorMinorPatch >nul

rem --tag-prefix "" so the version tags can go without "v" letter
rem --skip.commit --skip.bump
set ARGS=--tag-prefix "" --skip.tag --release-as %DOT_GIT_VERSION% 
if "%~1" equ "dry" set ARGS=--dry-run %ARGS%

standard-version %ARGS%

