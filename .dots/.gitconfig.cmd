@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git config
rem ::: 
rem ::: .GITCONFIG <useremail> <username>
rem ::: 
rem ::: Parameters: 
rem :::     useremail - user email address
rem :::     username - user name 
rem ::: 
rem ::: Description: 
rem :::     Runs git config --gloal and set user name and email address.
rem ::: 


if "%~2" equ "" goto :eof

echo Configuring user email address (%~1)...
git config --global user.email "%~1"                                                                                      
echo Configuring user name (%~2)...
git config --global user.name "%~2"
       


