import groovy.json.JsonSlurperClassic
properties([[$class: 'GitLabConnectionProperty', gitLabConnection: 'NAS']])

def updateStatus(String status) {
    updateGitlabCommitStatus(state: status);
}


def Object getGitVersion() {
	jsonText = bat(returnStdout: true, script: '@gitversion')
	println "${jsonText}"
	return new JsonSlurperClassic().parseText(jsonText)  			
}

def String getPackageFtpLinkText(String link, String text) {

	def ftp = "ftp://nas/builds/dots-cli/" + link
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
            
            nugetName = """dots-cli.${gitVersion.InformationalVersion}"""
            buildPath = """${env.CID_BUILD_PATH}\\dots-cli\\${env.BRANCH_NAME}\\${gitVersion.InformationalVersion}"""
        }
        
         stage('Publish') {
            milestone()

            def installScript = "${buildPath}\\${nugetName}.cmd"

            bat """
                for /f %%f in ('dir /b /s template.json') do type %%f | jq ".classifications += [\\"${gitVersion.InformationalVersion}\\"]" > %%f.ver && move %%f.ver %%f > nul
		set path=.\\.dots;%userprofile%\\.dots;%path%
                call .install
                nuget pack .nuspec -OutputDirectory ${buildPath} -NoDefaultExcludes -Version ${gitVersion.InformationalVersion}     
                if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

                echo del /s %userprofile%\\.templateengine\\dotnetcli\\dots-cli.*.nupkg > ${installScript}
                echo dotnet new -i ${buildPath}\\${nugetName}.nupkg >> ${installScript}
                echo pause >> ${installScript}             
                if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%
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
                dotnet new -u ${nugetName}
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
