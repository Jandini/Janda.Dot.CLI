### Jenkins

| master | develop |
|:------:|:-----------:|
|[![Build Status](http://nas:8081/buildStatus/icon?job=dots-cli/master)](http://nas:8081/job/dots-cli/job/master)|[![Build Status](http://nas:8081/buildStatus/icon?job=dots-cli/develop)](http://nas:8081/job/dots-cli/job/develop)|

### version 1.2.0

 * As user I want to use latest dotnet core 3.0 in dot templates
 * As user I want to use VS2019 solutions 


 - As user I want to see when foreach is scanning the folders so I know the command is foreach syntax
 - As developer I want to access dot repository directory name through DOT_CURRENT_DIR_NAME environment variable so I know what directory name the command was called from
 - As developer I want to access current directory path through DOT_CURRENT_DIR_PATH environment variable so I know what directory path the command was called from
 - As developer I want to access dot repository current branch through DOT_GIT_BRNACH environment variable
 - As developer I want to access dotset default repository path via DOT_BASE_PATH environemnt variable
 - As developer I want to access dotset default repository name via DOT_BASE_NAME environemnt variable
 - As developer I want to access current git version through DOT_GIT_VERSION environment variable
 - As user I can see ".dots prerequisites" instead of "Elevating privileges..." when I call .dots install 
 - As user I don't need .prerequisites as separate command 
 - As user I want to run .pack, .build and .restore commands recursively only when '*' is given. 
 - Fix endless loop when calling dotnet pack|build|restore and default solution does not exist.
 - As user I can run .pack, .build and .restore commands only within single project by giving '.' parameter. 
 - As developer I want all dot scripts to be stored in nuget package 
 - As developer I want to validate that all commands are inside nuget package 
 - As developer I want keep track the stories and history of changes in README.MD file
 - As developer I can define command flags so they can check command's constraints before the command is executed 
 - As user I can use .feature command to checkout feature branch so I can work on it 
 - As user I cannot execute git based commands outside git repositories 
 - As user I can run .init command in any folder without dotset or git repository check
 - As user I want the installer to replace old dots so the depricated commands are removed


### version 1.3.0

 * As developer I want to be able to store help usage within command scripts itself so I can display like ```type _dots.cmd | grep -o -P (?^<=rem).*```
 * As user I can upstream local branches using .mirror command	
 * As user I do not want any of dot commands to close cmd window if execute directly from it
 * As developer I want to remove dynamic dots script generation so it is easier to maintain dots command
 * As user I want to set gitlab base url through DOT_GITLAB_URL environment variable
 * As user I want to set gitlab user name using DOT_GITLAB_USER environment variable
 * As user I want to be able to undo last commit with keeping changes by default so I can commit the changes again
 * As user I don't want .build * to endup in endless loop

### Prerequisites

Chocolatey https://chocolatey.org/
```@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"```

Gitversion https://gitversion.readthedocs.io/en/latest/
```choco install gitversion.portable --pre```

Jq https://stedolan.github.io/jq/download/
```choco install jq```

Curl https://curl.haxx.se/download.html
```choco install curl```


### Develop

``` 
git clone http://nas/matt/dotnet.templates.git
cd dotnet.templates
git flow init -d
```


### Install 

Template packages are stored in ``` \\nas\builds\dotnet.templates\master\ ```

Example:
```
\\nas\builds\dotnet.templates\master\1.1.0.0\Dotnet.Common.Templates.1.1.0.cmd 
```

### Usage

Create new solution 
```sh 
dotnet new commonsln -n Hello.World
cd Hello.World
.init
```

Add new project

*New project must be added in Hello.World\src folder*

```sh
dotnet new commonlib -n Hello.World.Project
dotnet sln add Hello.World.Project 
```


Create solution with project
```
dotnet new commonsln -n Hello.World
cd Hello.World
call .init
cd src
dotnet new commonlib -n Hello.World.Project
dotnet sln add Hello.World.Project
git add .
git commit -m "Add project"
```

### GitLab

*An empty project must be created in gitlab http://nas/projects/new*

Add to GitLab

```sh
git remote remove origin
git remote add origin http://nas/matt/hello.world.git
git push -u origin --all
```


### Git

Git global setup
```sh
git config --global user.name "Matt"
git config --global user.email "matt.janda.kingston@gmail.com"
```

Create a new repository
```sh
git clone http://nas/matt/dotnet.templates.git
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

Push an existing folder
```sh
git init
git remote add origin http://nas/matt/dotnet.templates.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

Push an existing Git repository
```sh
git remote remove origin
```
or 

```sh
git remote rename origin old-origin
```

```sh
git remote add origin http://nas/matt/dotnet.templates.git
git push -u origin --all
git push -u origin --tags
```

Checkout develop branch
```sh
git clone http://nas/matt/dotnet.templates.git
git checkout develop
```
