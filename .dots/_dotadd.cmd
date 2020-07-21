set DOT_NEW_ARGS=
if defined DOT_ARG_NAMESPACE call :append_namespace %DOT_ARG_NAMESPACE%
if defined DOT_ARG_ADD-ARGS call :append_arg --addArgs
if defined DOT_DEFAULT_AUTHORS call :append_arg --authors "%DOT_DEFAULT_AUTHORS%"

echo Running dotnet new %1 -n %2%DOT_NEW_ARGS% %3
dotnet new %1 -n %2%DOT_NEW_ARGS% %3
goto :eof


:append_namespace
call _dotname "%~1" DOT_NAME_SPACE
call :append_arg "--nameSpace %DOT_NAME_SPACE%"
goto :eof



:append_arg
set DOT_NEW_ARGS=%DOT_NEW_ARGS% %~1
if "%~2" equ "" goto :eof
set DOT_NEW_ARGS=%DOT_NEW_ARGS% "%~2"

goto :eof