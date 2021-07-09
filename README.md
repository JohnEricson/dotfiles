# John's dotfiles

Personal config files for Bash, Windows PowerShell, PowerShell Core and Vim/Neovim. Works on Linux/Windows/WSL/Cygwin/Git Bash.
Good cross platform configuration that works similar on different operatingsystems.

## Install
To install these dotfiles and [chezmoi](https://www.chezmoi.io) which is the software used to easily manage them, just run these commands on a new machine:

### Unix
As your normal user run:
```console
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply JohnEricson
```

### Windows
Recommended way is to install chezmoi using [Chocolatey](https://chocolatey.org/install#individual). First make sure Chocolatey is installed and then run this command as Administrator: 
```console
choco install chezmoi
```
Then as your normal user run:
```console
chezmoi init --apply JohnEricson
```

#### Install default programs and do additional configuration of the machine
This is optional but recommended. Without this you may get an error message in the Windows Terminal that the default profile doesn't work. This is because this one uses pwsh as shell.

Ensure we are allowed to run PowerShell scripts:
```console
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

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
