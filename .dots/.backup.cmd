@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: File backup
rem ::: 
rem ::: .BACKUP [--nugets]
rem ::: 
rem ::: Parameters:
rem :::     nugets - backup local nuget packages only
rem ::: 
rem ::: Description: 
rem :::     Backup entire content of current folder into 7z archive. 
rem :::     The archive is located in ".dotbak" folder under user profile. 
rem :::     The archive name consist of current folder name and current date time timestamp. 
rem ::: 


if not defined DOT_ARG_NUGETS goto backup

set DOT_BASE_NAME=.nugetlocal
cd %USERPROFILE%\.nuget\local

:backup
 
set BACKUP_DIR=%USERPROFILE%\.dotbak\%DOT_DATE_STAMP%\%DOT_BASE_NAME%
set BACKUP_FILE=%DOT_BASE_NAME%-%DOT_TIME_STAMP%.7z

if not exist "%BACKUP_DIR%" md "%BACKUP_DIR%"
if %ERRORLEVEL% neq 0 exit /b

7z a "%BACKUP_DIR%\%BACKUP_FILE%" * -m0=lzma2 -mx=9 -r -xr!bin -xr!obj -xr!.vs %BACKUP_ARGS%

if not defined DOT_IS_FOREACH start "" "%BACKUP_DIR%"