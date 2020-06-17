@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Copy multiple folders into one location
rem ::: 
rem ::: .copyto <target path> [source path] [... source path]
rem ::: 
rem ::: Parameters:
rem :::     target path - target directory where all source folders will be copied in
rem :::     source path - source directory 
rem ::: 
rem ::: Description: 
rem :::     Use Robocopy to copy multiple source folders into one target location.
rem ::: 
rem ::: Examples: 
rem :::     .copyto D:\ X:\T001 Y:\T002 Y:\T003
rem :::     .copyto F:\ALL X:\T001 Y:\T002 Y:\T003
rem ::: 

set TARGET_PATH=%~1
set SOURCES=

echo Source(s) found: 
echo.
for %%I in (%*) do if "%%I" neq "%TARGET_PATH%" call :show_source "%%~fI"
echo.

set /P CONFIRM=Do you want to copy the source to %TARGET_PATH% now ? (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof

for %%I in (%*) do if "%%I" neq "%TARGET_PATH%" call :copy_files "%%~fI" "%TARGET_PATH%\%%~nI"
goto :eof


:copy_files 
if exist "%~1" robocopy "%~1" "%~2" /E
goto :eof


:show_source
if exist "%~1" echo   "%~1"
goto :eof