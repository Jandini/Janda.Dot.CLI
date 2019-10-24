@echo off
cd %TEMP%

SET COMMAND=.help
<nul set /p =Running %COMMAND%	
call %COMMAND% > nul
if %ERRORLEVEL% neq 1 echo [ FAILED ] && exit 1 /b
echo [ OK ]

call :help_test help
call :help_test addcon
call :help_test addlib
call :help_test addsln
call :help_test backup
call :help_test branch
call :help_test build
call :help_test clone
call :help_test commit 
call :help_test develop
call :help_test diff
call :help_test dotnet
call :help_test dots
call :help_test dotsln
call :help_test feature
call :help_test foreach
call :help_test gitlab
call :help_test init
call :help_test kawika
call :help_test master
call :help_test mirror
call :help_test net
call :help_test newsln
call :help_test origin
call :help_test pack
call :help_test prerequisites
call :help_test publish
call :help_test restore
call :help_test status
call :help_test sync
call :help_test undo
call :help_test version
call :help_test release


goto exit



:help_test
SET COMMAND=%1
<nul set /p =Running .help %COMMAND%	
call .help %COMMAND% > nul
if %ERRORLEVEL% neq 1 echo [ FAILED ] && exit 1 /b
echo [ OK ]
:EOF

:exit