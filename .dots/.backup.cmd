@call _dots %~n0 "Backup repository or local nuget packages" "[nuget]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if /i "%1" neq "nuget" goto backup

set DOT_BASE_NAME=.nugetlocal
cd %USERPROFILE%\.nuget\local

:backup
 
set BACKUP_DIR=%USERPROFILE%\.dotbak\%DATE_STAMP%\%DOT_BASE_NAME%
set BACKUP_FILE=%DOT_BASE_NAME%-%TIME_STAMP%.7z


if not exist %BACKUP_DIR% md %BACKUP_DIR% 
if %ERRORLEVEL% neq 0 exit /b

7z a %BACKUP_DIR%\%BACKUP_FILE% * -m0=lzma2 -mx=9 -r -xr!bin -xr!obj -xr!.vs %BACKUP_ARGS%
