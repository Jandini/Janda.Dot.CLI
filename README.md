# Janda.Dot.CLI



### Install

Download and install from command line: 
```

powershell.exe -NoP -NonI -ExecutionPolicy Bypass -Command "$branch='develop';$repo='Janda.Dot.CLI';$ProgressPreference = 'SilentlyContinue';[System.Net.ServicePointManager]::SecurityProtocol = 3072;Invoke-WebRequest -Uri \"https://github.com/Jandini/$repo/archive/$branch.zip\" -OutFile \"$branch.zip\";Expand-Archive -LiteralPath \"$branch.zip\" -DestinationPath $branch -Force;cd \"$branch\$repo-$branch\";.install.cmd"

```




Manual installation from command line: 

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


### Choco

PowerShell:
```
[System.Net.ServicePointManager]::Expect100Continue=$true;[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

CommandLine:
```
powershell.exe -NoP -NonI -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::Expect100Continue=$true;[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
```

### Prerequisites

```
choco install 7zip.install nuget.commandline git.install git jq curl gitversion.portable dotnetcore-sdk dotnetcore nodejs-lts
```


