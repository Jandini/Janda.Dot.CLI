import groovy.json.JsonSlurperClassic
properties([[$class: 'GitLabConnectionProperty', gitLabConnection: 'NAS']])

def appName = "dots-cli"

def updateStatus(String status) {
    updateGitlabCommitStatus(state: status);
}


def Object getGitVersion() {
	jsonText = bat(returnStdout: true, script: '@gitversion')
	println "${jsonText}"
	return new JsonSlurperClassic().parseText(jsonText)  			
}

def String getPackageFtpLinkText(String link, String text) {

	def ftp = "ftp://nas/builds/${appName}/" + link
	return hudson.console.ModelHyperlinkNote.encodeTo(ftp, text);
}

def void getPackageLinks(Object gitVersion) {

	branch = getPackageFtpLinkText("${gitVersion.BranchName}", gitVersion.BranchName)
	version = getPackageFtpLinkText("${gitVersion.BranchName}/${gitVersion.InformationalVersion}", gitVersion.InformationalVersion)
	
	println "Branch:    ${branch}\nVersion:   ${version}\n          "
}


node("matt10") {
    
    try {

        def gitVersion
        def nugetName
        def buildPath
        
        
        updateStatus('running')

        stage('Init') {
            milestone Integer.parseInt(env.BUILD_ID)
            deleteDir()  
        }
        
        stage('Checkout') {
            milestone()
            checkout scm
            gitVersion = getGitVersion();
            
            nugetName = """${appName}.${gitVersion.InformationalVersion}"""
            buildPath = """${env.CID_BUILD_PATH}\\${appName}\\${gitVersion.InformationalVersion}"""
        }
        
         stage('Publish') {
            milestone()

            def installScript = "${buildPath}\\${nugetName}.cmd"

            bat """
                set OUTPUT_DIR=${buildPath}
                call .pack noinstall
                if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%      

                echo dotnet new -u ${appName} > ${installScript}
                echo dotnet new -i ${buildPath}\\${nugetName}.nupkg >> ${installScript}
                echo pause >> ${installScript}
            """
        }
    
        stage('Install') {
            milestone()
            // remove all templateengine folder in case previous build fails
            bat """
                rd %USERPROFILE%\\.templateengine /s/q
                dotnet new -l && if %ERRORLEVEL% NEQ 0 exit %ERRORLEVEL%
                dotnet new -i ${buildPath}\\${nugetName}.nupkg && if %ERRORLEVEL% NEQ 0 exit %ERRORLEVEL%
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
