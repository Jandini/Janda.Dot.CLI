# dots-cli

| master | develop |
|:------:|:-----------:|
|[![Build Status](http://nas:8081/buildStatus/icon?job=dots-cli/master)](http://nas:8081/job/dots-cli/job/master)|[![Build Status](http://nas:8081/buildStatus/icon?job=dots-cli/develop)](http://nas:8081/job/dots-cli/job/develop)|


### Links

https://github.com/dotnet/dotnet-template-samples

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


feat - A new feature
fix - A bug fix
docs - Documentation only changes
style - Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
refactor - A code change that neither fixes a bug nor adds a feature
perf - A code change that improves performance
test - Adding missing tests or correcting existing tests
build - Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
ci - Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
chore - Other changes that don't modify src or test files
revert - Reverts a previous commit
