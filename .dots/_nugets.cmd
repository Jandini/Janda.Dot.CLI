@echo off
rem Configure .dot nuget source and feed. .dot's local nuget feed is %USERPROFILE%\.nuget\local
rem This can be overriden by %DOT_CID_NUGET_FEED% environment variable and redirected to any folder. 
set DOT_DEFAULT_NUGET_FEED=%USERPROFILE%\.nuget\local

rem if global variable DOT_CID_NUGET_FEED e.g. on build server then make it a local path 
if defined DOT_CID_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%DOT_CID_NUGET_FEED%

rem if local path is still not then create one
if not defined DOT_LOCAL_NUGET_FEED set DOT_LOCAL_NUGET_FEED=%DOT_DEFAULT_NUGET_FEED%

