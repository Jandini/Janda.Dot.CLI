if "%~1" equ "" goto :eof

set INPUT_NAME=%~1
set INPUT_VARIABLE=%~2
set RESULT=%INPUT_NAME%

if "%INPUT_NAME:~0,1%"=="." set RESULT=%DOT_BASE_NAME%.%INPUT_NAME:~1%
if "%INPUT_NAME%" equ "." set RESULT=%DOT_BASE_NAME%

set %INPUT_VARIABLE%=%RESULT%


