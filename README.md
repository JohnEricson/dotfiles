# John's dotfiles

Personal config files for Bash, Windows PowerShell, PowerShell Core and Vim/Neovim. Works on Linux/Windows/WSL/Cygwin/Git Bash.
Good cross platform configuration that works similar on different operatingsystems.

## Install
To install these dotfiles and [chezmoi](https://www.chezmoi.io) which is the software used to easily manage them, just run these commands on a new machine:

### Linux / Unix
As your normal user in your home dir run:
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply JohnEricson
```
If you get questions about entering username/password try this command instead:
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --guess-repo-url=false https://github.com/JohnEricson/dotfiles.git
```
The new config for bash will be used next time you login. To refresh your current session with the new config run:
```sh
. ~/.bashrc
```
#### Alternative one-liner
This both installs these dotfiles and [chezmoi](https://www.chezmoi.io) as well as refresh your current session with new bash config:
```sh
. <(curl -sL https://raw.github.com/JohnEricson/dotfiles/main/install.sh)
```

### Windows
This installs [chezmoi](https://www.chezmoi.io) in the official way in your `~/bin` dir. Same way as it's installed on Linux.

Start PowerShell as your normal user and run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```
After this in your home dir run (This allows your user to run *.ps1 scripts):
```powershell
(irm -useb https://get.chezmoi.io/ps1) | powershell -c -
```
Then run:
```powershell
~/bin/chezmoi init --apply JohnEricson
```
Close your PowerShell window and open a new one to refresh your shell with the new config.

## Manage configuration
This configuration creates an alias `cm` that calls the `chezmoi` command. This is to make chezmoi easier to work with.

### Update configuration to latest version on a machine
As your normal user run:
```sh
cm update
```
