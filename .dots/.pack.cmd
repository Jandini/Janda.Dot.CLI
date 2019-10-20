@call _dots %~n0 "Run dotnet pack for project within current folder, default solution or solutions defined in .dotset file" "[.|dot]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "." goto this
.foreach dotnet pack %1
goto exit

:this
.dotnet pack .

:exit