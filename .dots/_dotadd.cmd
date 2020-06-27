set DOT_NEW_ARGS=
if defined DOT_ARG_NAMESPACE call :append_namespace %DOT_ARG_NAMESPACE%
if defined DOT_ARG_ADD-ARGS call :append_arg --addArgs

echo Running dotnet new %1 -n %2 %DOT_NEW_ARGS% %3
dotnet new %1 -n %2%DOT_NEW_ARGS% %3
goto :eof


:append_namespace
call _dotname "%~1" DOT_NAME_SPACE
call :append_arg "--nameSpace %DOT_NAME_SPACE%"
goto :eof


:append_arg
set DOT_NEW_ARGS=%DOT_NEW_ARGS% %~1
goto :eof