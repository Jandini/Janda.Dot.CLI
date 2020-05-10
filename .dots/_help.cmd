set PARAM=%~1
rem something is really messed up here
rem if /i "%PARAM%" equ "--usage" goto echo_usage
if /i "%PARAM%" equ "--help" goto echo_help
exit /b 0

:echo_usage
if "%DOT_HELP_USAGE%" neq "" goto with_params
echo %2
exit /b 1

:with_params
rem use this trick to escspe syntax characters
for %%a in (%DOT_HELP_USAGE%) do echo %2 %%~a
exit /b 1

:echo_help
echo %2 - %DOT_HELP_TEXT%
exit /b 1


