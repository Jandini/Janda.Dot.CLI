@if "%1" equ "" _forsln %~n0 

pushd ..\..\src
dotnet build %1.sln --ignore-failed-sources 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
popd


