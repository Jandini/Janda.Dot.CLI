# Janda.Dot.CLI



### Install

Command line: 

1. Clone ```Janda.Dot.CLI``` repository
	```
	git clone http://nas/matt/Janda.Dot.CLI.git
	```

2. Change directory to ```Janda.Dot.CLI```
	```
	cd Janda.Dot.CLI
	```

3. Optionally checkout ```develop``` branch to install latest development build
	```
	git checkout develop
	```
4. Run ```.install.cmd``` 
	```
	.install
	```



Installation script downloads and install all required prerequisites.

 


#### Installation Example 

```
C:\Users\mjanda\source\repos>git clone http://nas/matt/Janda.Dot.CLI.git
Cloning into 'Janda.Dot.CLI'...
remote: Enumerating objects: 932, done.
remote: Counting objects: 100% (932/932), done.
remote: Compressing objects: 100% (427/427), done.
Rremote: Total 2566 (delta 600), reused 774 (delta 478), pack-reused 1634
Receiving objects: 100% (2566/2566), 350.05 KiB | 3.13 MiB/s, done.
Resolving deltas: 100% (1713/1713), done.

C:\Users\mjanda\source\repos>cd Janda.Dot.CLI
C:\Users\mjanda\source\repos\Janda.Dot.CLI>

C:\Users\mjanda\source\repos\Janda.Dot.CLI>git checkout develop
Switched to branch 'develop'
Your branch is up to date with 'origin/develop'.


C:\Users\mjanda\source\repos\Janda.Dot.CLI>.install
Checking prerequisites...
Building dots package...
Packing Janda.Dot.CLI.1.5.0-alpha.24.nupkg...
Attempting to build package from '.nuspec'.
Successfully created package 'bin\Janda.Dot.CLI.1.5.0-alpha.24.nupkg'.
Checking Janda.Dot.CLI.1.5.0-alpha.24.nupkg in bin...
Installing templates...
Templates 1.5.0-alpha.24 installed successfully.
Copying dots to C:\Users\mjanda\.dots\
Adding .dotversion file...
Build complete.
Installation complete.
```



#### Prerequisites Example

```
Chocolatey v0.10.15
Installing the following packages:
7zip.install
By installing you accept licenses for the packages.
Progress: Downloading 7zip.install 19.0... 100%

7zip.install v19.0 [Approved]
7zip.install package files install completed. Performing other installation steps.
Installing 64 bit version
Installing 7zip.install...
7zip.install has been installed.
7zip installed to 'C:\Program Files\7-Zip'
Added C:\ProgramData\chocolatey\bin\7z.exe shim pointed to 'c:\program files\7-zip\7z.exe'.
  7zip.install may be able to be automatically uninstalled.
 The install of 7zip.install was successful.
  Software installed to 'C:\Program Files\7-Zip\'

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Chocolatey v0.10.15
Installing the following packages:
nuget.commandline
By installing you accept licenses for the packages.
Progress: Downloading NuGet.CommandLine 5.7.0... 100%

NuGet.CommandLine v5.7.0 [Approved]
nuget.commandline package files install completed. Performing other installation steps.
 ShimGen has successfully created a shim for nuget.exe
 The install of nuget.commandline was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Chocolatey v0.10.15
Installing the following packages:
git.install
By installing you accept licenses for the packages.
git.install v2.28.0 already installed.
 Use --force to reinstall, specify a version to install, or try upgrade.

Chocolatey installed 0/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Warnings:
 - git.install - git.install v2.28.0 already installed.
 Use --force to reinstall, specify a version to install, or try upgrade.
Chocolatey v0.10.15
Installing the following packages:
git
By installing you accept licenses for the packages.

git v2.28.0 [Approved]
git package files install completed. Performing other installation steps.
 The install of git was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Did you know the proceeds of Pro (and some proceeds from other
 licensed editions) go into bettering the community infrastructure?
 Your support ensures an active community, keeps Chocolatey tip top,
 plus it nets you some awesome features!
 https://chocolatey.org/compare
Chocolatey v0.10.15
Installing the following packages:
jq
By installing you accept licenses for the packages.
Progress: Downloading jq 1.6... 100%

jq v1.6 [Approved]
jq package files install completed. Performing other installation steps.
Downloading jq 64 bit
  from 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe'
Progress: 100% - Completed download of C:\ProgramData\chocolatey\lib\jq\tools\jq.exe (3.36 MB).
Download of jq.exe (3.36 MB) completed.
Hashes match.
C:\ProgramData\chocolatey\lib\jq\tools\jq.exe
 ShimGen has successfully created a shim for jq.exe
 The install of jq was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Chocolatey v0.10.15
Installing the following packages:
curl
By installing you accept licenses for the packages.
curl v7.72.0 already installed.
 Use --force to reinstall, specify a version to install, or try upgrade.

Chocolatey installed 0/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Warnings:
 - curl - curl v7.72.0 already installed.
 Use --force to reinstall, specify a version to install, or try upgrade.

Enjoy using Chocolatey? Explore more amazing features to take your
experience to the next level at
 https://chocolatey.org/compare
Chocolatey v0.10.15
Installing the following packages:
gitversion.portable
By installing you accept licenses for the packages.
Progress: Downloading GitVersion.Portable 5.3.7... 100%

GitVersion.Portable v5.3.7 [Approved]
gitversion.portable package files install completed. Performing other installation steps.
Added C:\ProgramData\chocolatey\bin\gv.exe shim pointed to '..\lib\gitversion.portable\tools\gitversion.exe'.
 ShimGen has successfully created a shim for gitversion.exe
 The install of gitversion.portable was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 1/1 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Chocolatey v0.10.15
Installing the following packages:
dotnetcore-sdk
By installing you accept licenses for the packages.
Progress: Downloading vcredist2015 14.0.24215.20170201... 100%
Progress: Downloading vcredist140 14.26.28720.3... 100%
Progress: Downloading KB3033929 1.0.5... 100%
Progress: Downloading chocolatey-windowsupdate.extension 1.0.4... 100%
Progress: Downloading KB3035131 1.0.3... 100%
Progress: Downloading KB2919355 1.0.20160915... 100%
Progress: Downloading KB2919442 1.0.20160915... 100%
Progress: Downloading KB2999226 1.0.20181019... 100%
Progress: Downloading dotnetcore-sdk 3.1.402... 100%
Progress: Downloading KB2533623 1.0.4... 100%

chocolatey-windowsupdate.extension v1.0.4 [Approved]
chocolatey-windowsupdate.extension package files install completed. Performing other installation steps.
 Installed/updated chocolatey-windowsupdate extensions.
 The install of chocolatey-windowsupdate.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-windowsupdate'

KB3035131 v1.0.3 [Approved]
kb3035131 package files install completed. Performing other installation steps.
Skipping installation because update KB3035131 does not apply to this operating system (Microsoft Windows 10 Enterprise).
 The install of kb3035131 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB3033929 v1.0.5 [Approved]
kb3033929 package files install completed. Performing other installation steps.
Skipping installation because update KB3033929 does not apply to this operating system (Microsoft Windows 10 Enterprise).
 The install of kb3033929 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919442 v1.0.20160915 [Approved]
kb2919442 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919442 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2919355 v1.0.20160915 [Approved]
kb2919355 package files install completed. Performing other installation steps.
Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2.
 The install of kb2919355 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2999226 v1.0.20181019 [Approved] - Possibly broken
kb2999226 package files install completed. Performing other installation steps.
Skipping installation because update KB2999226 does not apply to this operating system (Microsoft Windows 10 Enterprise).
 The install of kb2999226 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

vcredist140 v14.26.28720.3 [Approved]
vcredist140 package files install completed. Performing other installation steps.
WARNING: Skipping installation of runtime for architecture x86 version 14.26.28720 because a newer version (14.27.29016) is already installed.
WARNING: Skipping installation of runtime for architecture x64 version 14.26.28720 because a newer version (14.27.29016) is already installed.
 The install of vcredist140 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

vcredist2015 v14.0.24215.20170201 [Approved]
vcredist2015 package files install completed. Performing other installation steps.
 The install of vcredist2015 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

KB2533623 v1.0.4 [Approved]
kb2533623 package files install completed. Performing other installation steps.
Skipping installation because update KB2533623 does not apply to this operating system (Microsoft Windows 10 Enterprise).
 The install of kb2533623 was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

dotnetcore-sdk v3.1.402 [Approved]
dotnetcore-sdk package files install completed. Performing other installation steps.
Downloading dotnetcore-sdk 64 bit
  from 'https://download.visualstudio.microsoft.com/download/pr/9706378b-f244-48a6-8cec-68a19a8b1678/1f90fd18eb892cbb0bf75d9cff377ccb/dotnet-sdk-3.1.402-win-x64.exe'
Progress: 100% - Completed download of C:\Users\mjanda\AppData\Local\Temp\chocolatey\dotnetcore-sdk\3.1.402\dotnet-sdk-3.1.402-win-x64.exe (126.04 MB).
Download of dotnet-sdk-3.1.402-win-x64.exe (126.04 MB) completed.
Hashes match.
Installing dotnetcore-sdk...
dotnetcore-sdk has been installed.
  dotnetcore-sdk can be automatically uninstalled.
 The install of dotnetcore-sdk was successful.
  Software installed as 'EXE', install location is likely default.

Chocolatey installed 10/10 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Installed:
 - kb2919355 v1.0.20160915
 - kb3033929 v1.0.5
 - dotnetcore-sdk v3.1.402
 - kb2999226 v1.0.20181019
 - vcredist2015 v14.0.24215.20170201
 - kb2919442 v1.0.20160915
 - kb2533623 v1.0.4
 - vcredist140 v14.26.28720.3
 - kb3035131 v1.0.3
 - chocolatey-windowsupdate.extension v1.0.4
Chocolatey v0.10.15
Installing the following packages:
dotnetcore
By installing you accept licenses for the packages.
Progress: Downloading dotnetcore-runtime 3.1.8... 100%
Progress: Downloading dotnetcore-runtime.install 3.1.8... 100%
Progress: Downloading dotnetcore 3.1.8... 100%

dotnetcore-runtime.install v3.1.8 [Approved]
dotnetcore-runtime.install package files install completed. Performing other installation steps.
Downloading dotnetcore-runtime.install 64 bit
  from 'https://download.visualstudio.microsoft.com/download/pr/e97d7732-c06a-4643-a38d-648a84b11469/1a2a148ed597c162945b348102927cb0/dotnet-runtime-3.1.8-win-x64.exe'
Progress: 100% - Completed download of C:\Users\mjanda\AppData\Local\Temp\chocolatey\dotnetcore-runtime.install\3.1.8\dotnet-runtime-3.1.8-win-x64.exe (24.88 MB).
Download of dotnet-runtime-3.1.8-win-x64.exe (24.88 MB) completed.
Hashes match.
Installing dotnetcore-runtime.install...
dotnetcore-runtime.install has been installed.
Downloading dotnetcore-runtime.install
  from 'https://download.visualstudio.microsoft.com/download/pr/ae01518b-55e7-4739-a2ab-fd09866069cf/0341c091719e4a41fd388a32b91bfc02/dotnet-runtime-3.1.8-win-x86.exe'
Progress: 100% - Completed download of C:\Users\mjanda\AppData\Local\Temp\chocolatey\dotnetcore-runtime.install\3.1.8\dotnet-runtime-3.1.8-win-x86.exe (22.11 MB).
Download of dotnet-runtime-3.1.8-win-x86.exe (22.11 MB) completed.
Hashes match.
Installing dotnetcore-runtime.install...
dotnetcore-runtime.install has been installed.
  dotnetcore-runtime.install may be able to be automatically uninstalled.
Environment Vars (like PATH) have changed. Close/reopen your shell to
 see the changes (or in powershell/cmd.exe just type `refreshenv`).
 The install of dotnetcore-runtime.install was successful.
  Software installed as 'exe', install location is likely default.

dotnetcore-runtime v3.1.8 [Approved]
dotnetcore-runtime package files install completed. Performing other installation steps.
 The install of dotnetcore-runtime was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

dotnetcore v3.1.8 [Approved]
dotnetcore package files install completed. Performing other installation steps.
 The install of dotnetcore was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 3/3 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Chocolatey v0.10.15
Installing the following packages:
nodejs-lts
By installing you accept licenses for the packages.
Progress: Downloading nodejs-lts 12.18.3... 100%

nodejs-lts v12.18.3 [Approved]
nodejs-lts package files install completed. Performing other installation steps.
Installing 64 bit version
Installing nodejs-lts...


```


