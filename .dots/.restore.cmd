@call _dots %~n0 "Run dotnet restore for project in current folder, repo's default solution or all BUILD_SLN defined in .dotset file" "[.|all]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

.foreach dotnet restore %1