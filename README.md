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
This both installs these dotfiles and [chezmoi](https://www.chezmoi.io) as well as refresh your current session with the new bash config:
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

## Git aliases

### Install
1) Add this to your `~/.gitconfig` file:
```
[include]
   path = .gitaliases
```

### Aliases

| Alias | Description |
|-------|-------------|
| `l`   | Displays a one-line log of commit history, showing commit hash, date, branch, commit message, and author. |
| `a`   | Shortcut for `git add`. |
| `ap`  | Interactively adds changes to the staging area. |
| `c`   | Shortcut for `git commit --verbose`. |
| `ca`  | Commits all changes, automatically staging tracked files, with verbose mode. |
| `cm`  | Shortcut for `git commit -m`, allowing you to specify the commit message directly. |
| `cmp`  | Same as alias `cm` but also push local changes to remote if commit is successful. |
| `cam` | Commits all changes with a specified commit message. |
| `camp` | Same as alias `cam` but also push local changes to remote if commit is successful. |
| `m`   | Amends the last commit with the changes made in the current working directory, maintaining the previous commit message. |
| `pl`  | Pull latest changes from remote. Shortcut for `git pull` |
| `p`   | Push local changes to remote. Shortcut for `git push` |
| `d`   | Shows the difference between the working directory and the index. |
| `ds`  | Shows the diffstat of changes between the working directory and the index. |
| `dc`  | Shows the difference between the index and the last commit. |
| `s`   | Displays a short status showing modified, added, and deleted files. |
| `co`  | Switch branch. Shortcut for `git checkout`. |
| `cob` | Creates a new branch and switches to it. |
| `b`   | Lists branches sorted by the last modified date. |
| `bd`  | Delete local branch. Shortcut for `git branch -d` |
| `st`  | Stash modified files. Shortcut for `git stash` |
| `po`  | Restore stashed files. Use after `st`. Shortcut for `git stash pop` |
| `la`  | Lists all git aliases configured in the `.gitconfig` file. |

Source code for the aliases: [~/.gitaliases](dot_gitaliases)

### How to use
The git aliases are exposed both in git and in bash so you can for example use `s` for `git status` like this:
#### bash
```bash
gs
```
#### git/PowerShell
```shell
git s
```
