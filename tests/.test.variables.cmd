@call _dots %~n0 "Environment variables test" "" "dg " %1 %2 %3
call .version

echo DOT_BASE_NAME=%DOT_BASE_NAME%
if "%DOT_BASE_NAME%" equ "" echo %%DOT_BASE_NAME%% is empty&&exit 1 /b

echo DOT_BASE_PATH=%DOT_BASE_PATH%
if "%DOT_BASE_PATH%" equ "" echo %%DOT_BASE_PATH%% is empty&&exit 1 /b

echo DOT_TIME_STAMP=%DOT_TIME_STAMP%
if "%DOT_TIME_STAMP%" equ "" echo %%DOT_TIME_STAMP%% is empty&&exit 1 /b

echo DOT_DATE_STAMP=%DOT_DATE_STAMP%
if "%DOT_DATE_STAMP%" equ "" echo %%DOT_DATE_STAMP%% is empty&&exit 1 /b

echo DOT_TYPE=%DOT_TYPE%
if "%DOT_TYPE%" equ "" echo %%DOT_TYPE%% is empty&&exit 1 /b

echo DOT_PATH=%DOT_PATH%
if "%DOT_PATH%" equ "" echo %%DOT_PATH%% is empty&&exit 1 /b

echo DOT_CONFIG=%DOT_CONFIG%
if "%DOT_CONFIG%" neq ".dotconfig" echo ERROR: %%DOT_CONFIG%% is not .dotconfig&&exit 1 /b

echo DOT_CONFIG_LOCAL=%DOT_CONFIG_LOCAL%
if "%DOT_CONFIG_LOCAL%" neq ".dotlocal" echo ERROR: %%DOT_CONFIG_LOCAL%% is not .dotlocal&&exit 1 /b


echo DOT_GIT_VERSION=%DOT_GIT_VERSION%
if "%DOT_GIT_VERSION%" equ "" echo %%DOT_GIT_VERSION%% is empty&&exit 1 /b

echo DOT_GIT_BRANCH=%DOT_GIT_BRANCH%
if "%DOT_GIT_BRANCH%" equ "" echo %%DOT_GIT_BRANCH%% is empty&&exit 1 /b


echo DOT_CURRENT_DIR_NAME=%DOT_CURRENT_DIR_NAME%
if "%DOT_CURRENT_DIR_NAME%" equ "" echo %%DOT_CURRENT_DIR_NAME%% is empty&&exit 1 /b

echo DOT_CURRENT_DIR_PATH=%DOT_CURRENT_DIR_PATH%
if "%DOT_CURRENT_DIR_PATH%" equ "" echo %%DOT_CURRENT_DIR_PATH%% is empty&&exit 1 /b


