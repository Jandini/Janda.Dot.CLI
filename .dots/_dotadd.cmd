if defined DOT_ARG_NAMESPACE set DOT_NEW_ARGS=--nameSpace %DOT_ARG_NAMESPACE%
if defined DOT_ARG_ADD-ARGS set DOT_NEW_ARGS=%DOT_NEW_ARGS% --addArgs

echo Running dotnet new %1 -n %2 %DOT_NEW_ARGS%
dotnet new %1 -n %2 %DOT_NEW_ARGS%


