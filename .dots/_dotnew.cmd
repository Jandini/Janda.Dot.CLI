if defined DOT_ARG_NAMESPACE set DOT_NEW_ARGS=--nameSpace %DOT_ARG_NAMESPACE% %DOT_NEW_ARGS%

dotnet new %1 -n %2 %DOT_NEW_ARGS%


