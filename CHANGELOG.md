# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

 * Create installer script that adds .dots to path. Download directly from git and install

 * Add optional parameter origin to .init command 
 * As developer I want to be able to store help usage within command scripts itself so I can display like ```type _dots.cmd | grep -o -P (?^<=rem).*```  rem usage:, rem desc:
 * Perhaps use find instead grep
 * As user I can upstream local branches using .mirror command ```git log @{push}.. &&echo %ERRORLEVEL%```
 * As user I do not want any of dot commands to close cmd window if execute directly from it

 * As developer I want to remove dynamic dots script generation so it is easier to maintain dots command

 * As user I want to be able to undo last commit with keeping changes by default so I can commit the changes again
 * As user I don't want .build * to endup in endless loop
 * Command .release should try to checkout branch like feature does 

 * Add .newlib command
 * Make add *.cmd dot parameters common i.e. addtest is the same as addlib
 * Add namespace parameter to addlib or addtest commands e.g. .addlib . Janda.Runtime  OR .addlib Janda.Runtime.OS Janda.Runtime
   This will generate <RootNamespace>Janda.Runtime</RootNamespace> in .csproj

 * double-dots scripts represents flows ? 



## [1.3.0]

### Added


 - Git hooks for Semantic Commit Messages https://www.conventionalcommits.org/, https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716, https://github.com/fteem/git-semantic-commits
 - New .clean command
 - The .push command pushes all branches followed by tags
 - Current build to Jenkinsfile
 - Added XUnit tests support. Added .addtest to add and .test to run tests
 - _nuget.cmd to configure path to DOT_LOCAL_NUGET_FEED and DOT_NUGET_SOURCES parameters 
 - .nuspec file builder
 - Dot.Console.Abstraction template
 - The template.json file parser error handling for pack command
 - Smarter update and revert of template version
 - Message "You are about to commit" to .commit command
 - New .push command
 - Expose new .net core 3 publishing features through DOT_PUBLISH_ARGUMENTS
 - DOT_PUBLISH_RUNTIMES to .dotconfig to define runtime targets publish
 - DOT_PUBLISH_ARGUMENTS to .dotconfig file to define list of parameters .e.g. -p:PublishSingleFile=true -p:PublishTrimmed=true
 - DOT_DEBUG environment variable
 - Added CHANGELOG.md file to dot repository
 - Comments handler for .dotconfig and .dotlocal files.
 - .dotlocal configuration file
 - template error handling for .newdot command.
 - git stash support to .init command. Allow to run init git flow after git clone from any remote and changes were made.
 - gitlog command
 - .newcon command to create new dot repo and add console application
 - .checkout command that allows checkout from partial branch name
 - double dots to avoid extension conflicts. e.g. ..master command will not conflict with .master extension 


### Changed

 - Fixed release tag comment. It was adding the version twice in tags.
 - Removed MSBUILDSINGLELOADCONTEXT=1 workaround from .dotconfig
 - GitVersion 5.3.3
 - Simplified .dotnet command
 - Replace "Jenkins" with repository name inside README.md
 - As user I want to set gitlab base url through DOT_GITLAB_URL environment variable
 - As user I want to set gitlab user name using DOT_GITLAB_USER environment variable
 - .version will retrive version only once if DOT_GIT_VERSION is already defined
 - Changed parameter noGit to noGitVersion. Git is alwasy part of dots. 
 - Update date time variables to use DOT_ prefiex
 - LOCAL_NUGET_FEED replaced with .dotconfig DOT_LOCAL_NUGET_FEED
 - Change BUILD_SLN to DOT_BUILD_SOLUTIONS
 - Change PUBLISH_PRJ to DOT_PUBLISH_PROJECTS
 - Renamed .dotset to .dotconfig
 - Upgraded project templates to .NET Core 3.1.4
 - Changed TargetFramework to netcoreapp3.1
 - Missing dotnet template causes odd behavior in .newdot
 - Changed diff to output only statistics
 - Replaced jq with gitversion /showvariable in version command
 - Optimized console application template
 - Replaced Microsoft.Extensions.CommandLineUtils 1.1.1 with the most CommandLineParser 2.8.0
 - New repos cannot be created within existing git repositories 
 - .branch use .checkout if branch not found


## [1.2.0] - 2019-11-27

### Issues

 * GitVersion 5.1.2
 * C:\Users\Administrator\.nuget\packages\gitversiontask\5.1.1\build\GitVersionTask.targets(10,9): error MSB4062: The "WriteVersionInfoToBuildLog" task could not be loaded from the assembly C:\Users\Administrator\.
   nuget\packages\gitversiontask\5.1.1\build\..\tools\netstandard2.0\GitVersionTask.MsBuild.dll. Assembly with same name is already loaded Confirm that the <UsingTask> declaration is correct, that the assembly and
   all its dependencies are available, and that the task contains a public class that implements Microsoft.Build.Framework.ITask. [C:\Users\Administrator\Source\Repos\Common\Common.Extensions\src\Common.Extensions.
   Hosting\Common.Extensions.Hosting.csproj]

 * WIP: You are working on feature/remove-watchers. Do you want to SWITCH to feature/philipe-extraction now (Y/[N])?y

 * C:\Users\Administrator\Source\Repos\Common\Common.Extensions>.restore
   MSBUILD : error MSB1003: Specify a project or solution file. The current working directory does not contain a project or solution file.
   Searching for dotset repositories in Common.Extensions...
   Running dotnet for C:\Users\Administrator\Source\Repos\Common\Common.Extensions\.

 * Missing dotnet template causes odd behaviour in .newdot (fixed in 1.3.0)


### Added

 - As developer I want to run basic unit tests so I can ensure the essential commands are still working
 - As developer I want to validate that all commands are inside nuget package 
 - As developer I want keep track the stories and history of changes in CHANGELOG.md file
 - As developer I can define command flags so they can check command's constraints before the command is executed 

### Changed

 - As user I want to run publish command with '.' parameter so I can publish current library or application without need of using dotset definition 
 - Change to .status ```git status -sb```
 - As developer and user I want to create dot repository using .newdot command
 - As user and developer I want to dot-cli templates to be renamed to dots cli; dots cid; dots solution; dots console; dots library
 - As developer I want all dot scripts to be stored in nuget package 
 - As user I can run .init command in any folder without dotset or git repository check
 - As user I want to run .pack, .build and .restore commands recursively only when '*' is given. 
 - As user I want to use latest dotnet core 3.0 in dot templates
 - As developer I want to use latest gitversion task 5.1.1
 - As developer I want to use latest serilog 3.0.1
 - As user I want to use VS2019 solutions so dot cli is up to date 
 - As user I want to see when foreach is scanning the folders so I know the command is foreach syntax
 - As user I want the installer to replace old dots so the deprecated commands are removed
 - As developer I want to access dot repository directory name through DOT_CURRENT_DIR_NAME environment variable so I know what directory name the command was called from
 - As developer I want to access current directory path through DOT_CURRENT_DIR_PATH environment variable so I know what directory path the command was called from
 - As developer I want to access dot repository current branch through DOT_GIT_BRNACH environment variable
 - As developer I want to access dotset default repository path via DOT_BASE_PATH environment variable
 - As developer I want to access dotset default repository name via DOT_BASE_NAME environment variable
 - As developer I want to access current git version through DOT_GIT_VERSION environment variable
 - As user I can see ".dots prerequisites" instead of "Elevating privileges..." when I call .dots install 
 - As user I want dotnet pack|build|restore to complete when default solution file does not exist so it not falls into endless loop
 - As user I can run .pack, .build and .restore commands only within single project by giving '.' parameter. 
 - As user I can use .feature command to checkout feature branch so I can work on it 
 - As user I cannot execute git based commands outside git repositories 

### Removed

 - As user I don't need .prerequisites as separate command 
   

## [1.1.0] - 2019-10-20

 - We are walking

## [1.0.0] - 2019-10-18

 - Hello world 