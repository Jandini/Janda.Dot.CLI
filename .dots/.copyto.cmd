@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: File copy 
rem ::: 
rem ::: .copyto <target path> <source path> [... source path] [--shutdown]
rem ::: 
rem ::: Parameters:
rem :::     target path - target directory where all source folders will be copied in
rem :::     source path - source directory 
rem :::     shutdown - optional shutdown after copy is complete
rem ::: 
rem ::: Description: 
rem :::     Use Robocopy to copy multiple source folders into one target location.
rem :::     The --shutdown switch cannot preceed target path parameter.
rem ::: 
rem ::: Examples: 
rem :::     .copyto D:\ X:\T001 Y:\T002 Y:\T003
rem :::     .copyto F:\ALL X:\T001 Y:\T002 Y:\T003
rem ::: 

set TARGET_PATH=%~1
set SOURCES=

echo Source(s) found: 
echo.
for %%I in (%*) do call :show_source "%%I" "%%~fI"
if defined COPYERROR echo One or more sources not found.&exit /b %COPYERROR%
if not defined HAS_SOURCE echo No sources provided.&echo.&.help copyto
echo.
echo WARNING: This computer will powered down when copy is completed successfuly.
set /P CONFIRM=Do you want to copy the source to %TARGET_PATH% now ? (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof

for %%I in (%*) do call :copy_source "%%I" "%%~fI" "%%~nI"
if defined COPYERROR echo Copy failed with error code: %COPYERROR%&exit /b %COPYERROR%

echo Copy completed successfully.
if defined DOT_ARG_SHUTDOWN echo Shutting down this computer...&shutdown -s -t 120

goto :eof


:copy_source
set SOURCE_PATH=%~1
rem skip first parameter
if "%SOURCE_PATH%" equ "%TARGET_PATH%" goto :eof
rem skip -- switches
if "%SOURCE_PATH:~0,1%" equ "-" goto :eof

echo Copying %SOURCE_PATH% to %TARGET_PATH% 
call :copy_files "%~2" "%TARGET_PATH%\%~3"
goto :eof

:copy_files 
if not exist "%~1" echo %~1 does not exit.&exit /b 1
robocopy "%~1" "%~2" /E
if %ERRORLEVEL% neq 0 set COPYERROR=%ERRORLEVEL%
goto :eof

:show_source
set SOURCE_PATH=%~1

rem skip first parameter
if "%SOURCE_PATH%" equ "%TARGET_PATH%" goto :eof
rem skip -- switches
if "%SOURCE_PATH:~0,1%" equ "-" goto :eof

if not exist "%SOURCE_PATH%" set COPYERROR=16
if exist "%SOURCE_PATH%" (echo   "%SOURCE_PATH%"&set HAS_SOURCE=1) else (echo   "%SOURCE_PATH%" not found)

goto :eof