set PARAM=%~1
if /i "%PARAM%" equ "--help" goto help 
if /i "%PARAM%" equ "--usage" goto usage

goto continue

:help
echo %2 - %DOT_HELP_TEXT%
exit /b 1

:usage
if "%DOT_HELP_USAGE%" equ "" goto parameters_not_required

rem use this trick to escspe syntax characters
for %%a in (%DOT_HELP_USAGE%) do echo %2 %%~a
exit /b 1

:parameters_not_required
echo %2 
exit /b 1

:continue
