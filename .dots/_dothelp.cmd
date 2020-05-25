@echo off
if "%~1" equ "" goto :eof

setlocal enabledelayedexpansion

for /F "tokens=* usebackq" %%G in (`type %~1.cmd^|findstr /irc:"rem ::: .*"`) do (
  set LINE=%%G 
  set OUTPUT=!LINE:~8!
  set TRIM=!OUTPUT: =!
  if "!TRIM!" neq "" (echo !OUTPUT!) else (echo.)
  if "%~2" equ "desc" goto :eof
)


