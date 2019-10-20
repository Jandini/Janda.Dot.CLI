import groovy.json.JsonSlurperClassic
properties([[$class: 'GitLabConnectionProperty', gitLabConnection: 'NAS']])

env.REPO_NAME = "dots-cli"
env.FTP_BASE_URL = "ftp://nas/builds/${env.REPO_NAME}/"

def updateStatus(String status) {
    updateGitlabCommitStatus(state: status);
}


def Object getGitVersion() {
	jsonText = bat(returnStdout: true, script: '@gitversion')
	println "${jsonText}"
	return new JsonSlurperClassic().parseText(jsonText)  			
}

def String getPackageFtpLinkText(String link, String text) {
	return hudson.console.ModelHyperlinkNote.encodeTo(env.FTP_BASE_URL + link, text);
}

def void getPackageLinks(Object gitVersion) {

	branch = getPackageFtpLinkText("${gitVersion.BranchName}", gitVersion.BranchName)
	version = getPackageFtpLinkText("${gitVersion.BranchName}/${gitVersion.InformationalVersion}", gitVersion.InformationalVersion)
	
	println "Branch:    ${branch}\nVersion:   ${version}\n          "
}


node("matt10") {
    
    try {

        def gitVersion
        def packageName
        def packageOutputPath

        updateStatus('running')

        stage('Init') {
            milestone Integer.parseInt(env.BUILD_ID)
            deleteDir()  
        }
        
        stage('Checkout') {
            milestone()
            checkout scm
            gitVersion = getGitVersion();
            
            packageName = """${env.REPO_NAME}.${gitVersion.InformationalVersion}"""
            packageOutputPath = """${env.CID_BUILD_PATH}\\${env.REPO_NAME}\\${env.BRANCH_NAME}\\${gitVersion.InformationalVersion}"""
        }
        
         stage('Publish') {
            milestone()

            def installScript = "${packageOutputPath}\\${packageName}.cmd"

            bat """
                set OUTPUT_DIR=${packageOutputPath}
                call .pack noinstall
                if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%      

                echo dotnet new -u ${env.REPO_NAME} > ${installScript}
                echo dotnet new -i ${packageOutputPath}\\${packageName}.nupkg >> ${installScript}
                echo pause >> ${installScript}
            """
        }
    
        stage('Install') {
            milestone()
            // remove all templateengine folder in case previous build fails
            bat """
                rd %USERPROFILE%\\.templateengine /s/q
                dotnet new -l && if %ERRORLEVEL% NEQ 0 exit %ERRORLEVEL%
                dotnet new -i ${packageOutputPath}\\${packageName}.nupkg && if %ERRORLEVEL% NEQ 0 exit %ERRORLEVEL%
            """
        }

        stage('Deploy') {
            milestone()
            // install global .dots
            bat """
               .dots install	   
            """
        }

        stage('Uninstall') {
            milestone()
            bat """
               call .uninstall
            """
        }
                
        stage('Cleanup') {
            milestone()
            deleteDir()                
        }
        
        stage ('Package') {
            getPackageLinks(gitVersion)	
        }
       
        updateStatus('success')
    }
    catch (e) {
        updateStatus('failed')
        throw e
    }
}
