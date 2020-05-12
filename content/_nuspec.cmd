@echo off
set output=..\!nuspec.content
echo   ^<files^> > %output%
for /R %%G in ("*.*") do if %%~nxG neq %~nx0 echo     ^<file src="%%~pG%%~nxG" target="%%~pG%%~nxG" /^> >> %output%
echo   ^</files^> >> %output%