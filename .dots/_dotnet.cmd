@set COMMAND=%~1
@set PARAM=%~2
@set REQUIRE_DOT=--require-dot
@if "%PARAM%" equ "*" set REQUIRE_DOT=

@call _dots %~n0 %* %REQUIRE_DOT%
if %ERRORLEVEL% equ 1 exit /b

if "%PARAM%" equ "*" goto foreach 
.dotnet %COMMAND% %PARAM%

:foreach
.foreach dotnet %COMMAND% %PARAM%
