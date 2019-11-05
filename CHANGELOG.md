# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

 * As user I want to run publish command with '.' parameter so I can publish current library or application without need of using dotset definition 
 * As developer I want to be able to store help usage within command scripts itself so I can display like ```type _dots.cmd | grep -o -P (?^<=rem).*```
 * As user I can upstream local branches using .mirror command	
 * As user I do not want any of dot commands to close cmd window if execute directly from it
 * As developer I want to remove dynamic dots script generation so it is easier to maintain dots command
 * As user I want to set gitlab base url through DOT_GITLAB_URL environment variable
 * As user I want to set gitlab user name using DOT_GITLAB_USER environment variable
 * As user I want to be able to undo last commit with keeping changes by default so I can commit the changes again
 * As user I don't want .build * to endup in endless loop
 * As user and developer I want to dot-cli templates to be renamed to dots cli; dots cid; dots solution; dots console; dots library



## [1.2.0] 

### Added

 - As developer I want to run basic unit tests so I can ensure the essential commands are still working
 - As developer I want to validate that all commands are inside nuget package 
 - As developer I want keep track the stories and history of changes in CHANGELOG.md file
 - As developer I can define command flags so they can check command's constraints before the command is executed 


### Changed

 - As developer I want all dot scripts to be stored in nuget package 
 - As user I can run .init command in any folder without dotset or git repository check
 - As user I want to run .pack, .build and .restore commands recursively only when '*' is given. 
 - As user I want to use latest dotnet core 3.0 in dot templates
 - As developer I want to use latest gitversion task 5.1.1
 - As developer I want to use latest serilog 3.0.1
 - As user I want to use VS2019 solutions so dot cli is up to date 
 - As user I want to see when foreach is scanning the folders so I know the command is foreach syntax
 - As user I want the installer to replace old dots so the depricated commands are removed
 - As developer I want to access dot repository directory name through DOT_CURRENT_DIR_NAME environment variable so I know what directory name the command was called from
 - As developer I want to access current directory path through DOT_CURRENT_DIR_PATH environment variable so I know what directory path the command was called from
 - As developer I want to access dot repository current branch through DOT_GIT_BRNACH environment variable
 - As developer I want to access dotset default repository path via DOT_BASE_PATH environemnt variable
 - As developer I want to access dotset default repository name via DOT_BASE_NAME environemnt variable
 - As developer I want to access current git version through DOT_GIT_VERSION environment variable
 - As user I can see ".dots prerequisites" instead of "Elevating privileges..." when I call .dots install 
 - As user I want dotnet pack|build|restore to complete when default solution file does not exist so it not falls into endless loop
 - As user I can run .pack, .build and .restore commands only within single project by giving '.' parameter. 
 - As user I can use .feature command to checkout feature branch so I can work on it 
 - As user I cannot execute git based commands outside git repositories 

### Removed
 
 - As user I don't need .prerequisites as separate command 
