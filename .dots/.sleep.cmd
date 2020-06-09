@call _dots %~n0 "   " %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Go to sleep now
rem ::: 
rem ::: .SLEEP
rem ::: 

rem Turn off hibernation because "rundll32.exe powrprof.dll,SetSuspendState 0,1,0" does not perform Sleep or Hybrid Sleep unless Hibernate is turned OFF. Instead, it enters into Hibernate state.
powercfg /H OFF 2>nul

rem Go to sleep now
rundll32.exe powrprof.dll,SetSuspendState 0,1,0