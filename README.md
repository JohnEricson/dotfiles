# John's dotfiles

Personal config files for Bash, Windows PowerShell, PowerShell Core and Vim/Neovim. Works on Linux/Windows/WSL/Cygwin/Git Bash.
Good cross platform configuration that works similar on different operatingsystems.

## Install
To install these dotfiles and [chezmoi](https://www.chezmoi.io) which is the software used to easily manage them, just run these commands on a new machine:

### Unix
As your normal user in your home dir run:
```console
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply JohnEricson
```
If you get questions about entering username/password try this command instead:
```console
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply --guess-repo-url=false https://github.com/JohnEricson/dotfiles.git
```

### Windows
Recommended way is to install chezmoi using [Chocolatey](https://chocolatey.org/install#individual). First make sure Chocolatey is installed by running this command as Administrator:
```console
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
After this as Administrator run:
```console
choco install chezmoi
```
After this start new PowerShell as your normal user and run:
```console
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```
Then finally in the same PowerShell window run:
```console
chezmoi init --apply JohnEricson
```

#### Install default programs and do additional configuration of the machine
This is optional but recommended. Without this you may get an error message in the Windows Terminal that the default profile doesn't work. This is because this one uses pwsh as shell.

Install default programs and do additional configuration of the machine
```console
~\Documents\Scripts\install_packages.ps1
```

## Manage configuration
This configuration creates an alias `cm` that calls the `chezmoi` command. This is to make chezmoi easier to work with.

### Update configuration to latest version on a machine
As your normal user run:
```console
cm update
```
