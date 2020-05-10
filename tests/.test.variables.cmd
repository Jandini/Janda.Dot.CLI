@call _dots %~n0 "Environment variables test" "" "dg " %1 %2 %3
call .version

echo DOT_BASE_NAME=%DOT_BASE_NAME%
if "%DOT_BASE_NAME%" equ "" echo %%DOT_BASE_NAME%% is empty&&exit 1 /b

echo DOT_BASE_PATH=%DOT_BASE_PATH%
if "%DOT_BASE_PATH%" equ "" echo %%DOT_BASE_PATH%% is empty&&exit 1 /b

echo TIME_STAMP=%TIME_STAMP%
if "%TIME_STAMP%" equ "" echo %%TIME_STAMP%% is empty&&exit 1 /b

echo DATE_STAMP=%DATE_STAMP%
if "%DATE_STAMP%" equ "" echo %%DATE_STAMP%% is empty&&exit 1 /b

echo DOTS_TYPE=%DOTS_TYPE%
if "%DOTS_TYPE%" equ "" echo %%DOTS_TYPE%% is empty&&exit 1 /b

echo DOTS_PATH=%DOTS_PATH%
if "%DOTS_PATH%" equ "" echo %%DOTS_PATH%% is empty&&exit 1 /b

echo DOTS_CONFIG=%DOTS_CONFIG%
if "%DOTS_CONFIG%" neq ".dotconfig" echo ERROR: %%DOTS_CONFIG%% is not .dotconfig&&exit 1 /b

echo DOTS_CONFIG_LOCAL=%DOTS_CONFIG_LOCAL%
if "%DOTS_CONFIG_LOCAL%" neq ".dotlocal" echo ERROR: %%DOTS_CONFIG_LOCAL%% is not .dotlocal&&exit 1 /b


echo DOT_GIT_VERSION=%DOT_GIT_VERSION%
if "%DOT_GIT_VERSION%" equ "" echo %%DOT_GIT_VERSION%% is empty&&exit 1 /b

echo DOT_GIT_BRANCH=%DOT_GIT_BRANCH%
if "%DOT_GIT_BRANCH%" equ "" echo %%DOT_GIT_BRANCH%% is empty&&exit 1 /b


echo DOT_CURRENT_DIR_NAME=%DOT_CURRENT_DIR_NAME%
if "%DOT_CURRENT_DIR_NAME%" equ "" echo %%DOT_CURRENT_DIR_NAME%% is empty&&exit 1 /b

echo DOT_CURRENT_DIR_PATH=%DOT_CURRENT_DIR_PATH%
if "%DOT_CURRENT_DIR_PATH%" equ "" echo %%DOT_CURRENT_DIR_PATH%% is empty&&exit 1 /b


