@call _dots %~n0 "Environment variables test" "" "dg " %1 %2 %3
call .version

echo BASE_NAME=%BASE_NAME%
if "%BASE_NAME%" equ "" echo %%BASE_NAME%% is empty&&exit 1 /b

echo TIME_STAMP=%TIME_STAMP%
if "%TIME_STAMP%" equ "" echo %%TIME_STAMP%% is empty&&exit 1 /b

echo DATE_STAMP=%DATE_STAMP%
if "%DATE_STAMP%" equ "" echo %%DATE_STAMP%% is empty&&exit 1 /b

echo CURRENT_DIR_PATH=%CURRENT_DIR_PATH%
if "%CURRENT_DIR_PATH%" equ "" echo %%CURRENT_DIR_PATH%% is empty&&exit 1 /b

echo CURRENT_DIR_NAME=%CURRENT_DIR_NAME%
if "%CURRENT_DIR_NAME%" equ "" echo %%CURRENT_DIR_NAME%% is empty&&exit 1 /b

echo DOTS_TYPE=%DOTS_TYPE%
if "%DOTS_TYPE%" equ "" echo %%DOTS_TYPE%% is empty&&exit 1 /b

echo DOTS_PATH=%DOTS_PATH%
if "%DOTS_PATH%" equ "" echo %%DOTS_PATH%% is empty&&exit 1 /b

echo DOTS_FILE=%DOTS_FILE%
if "%DOTS_FILE%" neq ".dotset" echo %%DOTS_FILE%% is not .dotset&&exit 1 /b

echo DOT_GITVERSION=%DOT_GITVERSION%
if "%DOT_GITVERSION%" equ "" echo %%DOT_GITVERSION%% is empty&&exit 1 /b


echo CURRENT_BRANCH=%CURRENT_BRANCH%
if "%CURRENT_BRANCH%" equ "" echo %%CURRENT_BRANCH%% is empty&&exit 1 /b


