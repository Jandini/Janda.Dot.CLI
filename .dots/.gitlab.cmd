@call _dots %~n0 "Push git repository into remote DOT_CID_GITLAB_URL using DOT_CID_GITLAB_TOKEN" "[project name]" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Push git repository into remote DOT_CID_GITLAB_URL using DOT_CID_GITLAB_TOKEN
rem ::: 

set PROJECT_NAME=%DOT_BASE_NAME%
if "%1" neq "" set PROJECT_NAME=%1

if "%DOT_CID_GITLAB_URL%" == "" ( echo DOT_CID_GITLAB_URL not set && goto exit )

set GITLAB_API_URL=%DOT_CID_GITLAB_URL%/api/v4

set CURL_OUTPUT=%TEMP%\.curl.log
set CURL_PARAMS=--silent --fail --show-error

echo Accessing gitlab %GITLAB_API_URL%
curl %CURL_PARAMS% --header "PRIVATE-TOKEN: %DOT_CID_GITLAB_TOKEN%" -X GET %GITLAB_API_URL%/projects > %CURL_OUTPUT%
if %ERRORLEVEL% neq 0 goto exit

echo Pushing project to gitlab
git push --all origin
if %ERRORLEVEL% neq 0 goto exit

echo Pushing tags to gitlab
git push --tag origin
if %ERRORLEVEL% neq 0 goto exit

if "%DOT_CID_JENKINS_URL%" equ "" ( echo DOT_CID_JENKINS_URL is not set. Skipping jenkins setup... && goto exit )

set JENKINS_JOB=%DOT_CID_JENKINS_URL%/job
set JENKINS_USER=%DOT_CID_JENKINS_USER%:%DOT_CID_JENKINS_TOKEN%

echo Accessing jenkins %DOT_CID_JENKINS_URL%
curl %CURL_PARAMS% -X GET %DOT_CID_JENKINS_URL% --user %JENKINS_USER% > %CURL_OUTPUT%
if %ERRORLEVEL% neq 0 goto exit

echo Running jenkins seeder 
curl -X POST %JENKINS_JOB%/jenkins.seeder/job/master/build?delay=0 --user %JENKINS_USER% 


echo Waiting for jenkins pipeline 
:wait
ping localhost -n 3 > nul
curl --silent --fail -X GET %JENKINS_JOB%/%PROJECT_NAME% --user %JENKINS_USER% > %CURL_OUTPUT%
if %ERRORLEVEL% neq 0 goto wait

echo Jenkins pipeline created successfully 
curl %CURL_PARAMS% -X POST %JENKINS_JOB%/%PROJECT_NAME%/build?delay=0sec --user %JENKINS_USER% > %CURL_OUTPUT%

:exit




