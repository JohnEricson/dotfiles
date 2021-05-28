# John's dotfiles

Personal config files for Bash, Vim, Windows PowerShell and PowerShell Core. Works on Linux/Cygwin/WSL/Windows.

## Install
To install these dotfiles and [chezmoi](https://www.chezmoi.io) which is the software used to easily manage them, just run these commands on a new machine:

### Unix
As your normal user run:
```console
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply JohnEricson
```

### Windows
Recommended way is to install [chezmoi] using [Chocolatey](https://chocolatey.org/install#individual). First make sure Chocolatey is installed and then run this command as Administrator: 
```console
choco install chezmoi
```
Then as your normal user run:
```console
chezmoi init --apply JohnEricson
```