set DOT_PROJECT_NAME=%DOT_ARG_DEFAULT%

if defined DOT_ARG_PROJECT set DOT_PROJECT_NAME=%DOT_ARG_PROJECT%

call .newdot %DOT_ARG_DEFAULT%
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL% /b

call .%1 %DOT_PROJECT_NAME% %2 %3 %4 %5 %6 %7 %8 %9
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL% /b
