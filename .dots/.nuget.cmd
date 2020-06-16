@call _dots %~n0 "   " %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

set DOT_PSCMD="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command

echo Removing Janda.* non-release and non-alpha packages from nuget cache...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\packages'; Get-ChildItem -Path $path -Filter 'janda.*' -Directory | Get-ChildItem | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host "
rem | Remove-Item -Recurse

echo Removing non-release and non-alpha packages from local nuget...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\local'; Get-ChildItem -Path $path -Recurse -Directory | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host " 
rem | Remove-Item -Recurse