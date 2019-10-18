@echo off
echo   ^<files^> > _nuspec.files
echo     ^<file src=".dots\template.json" target="content\DotScripts\.template.config\template.json" /^> >> _nuspec.files
for %%G in ("*.cmd") do if %%~nxG neq %~nx0 echo     ^<file src=".dots\%%~nxG" target="content\DotScripts\.dots\%%~nxG" /^> >> _nuspec.files
echo   ^</files^> >> _nuspec.files