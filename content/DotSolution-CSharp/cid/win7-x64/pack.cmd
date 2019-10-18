@if "%1" equ "" _forsln %~n0 

pushd ..\..\src
dotnet pack %1.sln --configuration Release --ignore-failed-sources /p:ApplyVersioning=true
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
popd

