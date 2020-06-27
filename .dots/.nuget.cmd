@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots nuget
rem ::: 
rem ::: .NUGET [--delete branch|nonalpha] [--branch name]
rem ::: 
rem ::: Parameters: 
rem :::     delete - Delete nuget packages created within current "branch" or all "nonalpha" packages
rem :::     branch - Override current branch name 
rem ::: 
rem ::: Description: 
rem :::     ... WIP
rem ::: 

set DOT_PSCMD="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command

echo Removing Janda.* non-release and non-alpha packages from nuget cache...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\packages'; Get-ChildItem -Path $path -Filter 'janda.*' -Directory | Get-ChildItem | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host "
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\packages'; Get-ChildItem -Path $path -Filter 'janda.*' -Directory | Get-ChildItem | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Remove-Item -Recurse "


echo Removing non-release and non-alpha packages from local nuget...
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\local'; Get-ChildItem -Path $path -Recurse -Directory | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Out-Host " 
%DOT_PSCMD% "$path = $env:userprofile + '\.nuget\local'; Get-ChildItem -Path $path -Recurse -Directory | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -like '*.*.*-*' -and $_.Name -notlike '*alpha*'} | Remove-Item -Recurse " 
