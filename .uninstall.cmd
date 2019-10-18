@call _dots %~n0 "Uninstall package" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

echo Uninstalling from created packages 
for /R "bin" %%f in (*.nupkg) do dotnet new -u %%~nf > nul

call .version
set PACKAGE=%BASE_NAME%.%VERSION%
echo Uninstalling %PACKAGE%
dotnet new -u %PACKAGE% > nul

rem Try to delete package from user profile folder
del /s %userprofile%\.templateengine\dotnetcli\%BASE_NAME%.*.nupkg 2> nul

dotnet new -l

