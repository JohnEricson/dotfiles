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
On Ubuntu the `curl` command is not installed by default so the equivalent using wget is:
```sh
sh -c "$(wget -qO- get.chezmoi.io)" -- init --apply JohnEricson
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

## Keyboard shortcuts

### Neovim/Vim

| Keyboard Shortcut | Description |
|-------------------|-------------|
| *                 | Search forward for word under cursor |
| #                 | Search backward for word under cursor |
| .                 | Repeat the last buffer operation. For example add same inputted text or do same manipulation as before |
| Ctrl+PgUp         | Go to left tab |
| Ctrl+PgDn         | Go to right tab |
| Ctrl+h            | Go to previous buffer |
| Ctrl+l            | Go to next buffer |
| Shift+H           | Go to top of page |
| Shift+L           | Go to bottom of page |
| h j k l           | Navigate left, down, up, right |
| zf                | Create fold of selected text |
| zo                | Open fold |
| zc                | Close fold |
| zd                | Delete fold |
| za                | Toggle fold |
| w                 | Navigate one word forward |
| b                 | Navigate one word backward |
| f                 | Navigate forward to first matching character pressed after f |
| t                 | Navigate forward to one character before first matching character pressed after f |
| gd                | Go to definition. For example go to function in Python |
| Shift+k           | Enter link in :help |
| Enter             | Enter link in :help (only in help) |
| Ctrl+o            | Go backward |
| Ctrl+r*           | Paste on command line. Instead of using Shift-Insert to insert the marked text, use Vim registers. So first copy your line using a yank command like 0y$ and then use :Ctrl-r0 to paste it into the command line. From: https://vi.stackexchange.com/questions/38508/paste-command-to-command-mode-instead-of-insert-mode |
| ":p                | Paste last command ran on command line. From: https://stackoverflow.com/questions/7047618/how-to-copy-text-from-command-line-mode-in-vim |
| Ctrl+f (Command Line mode) | Opens the history of all commands you have ran in Command Line. Here you can paste the one you want. From: https://stackoverflow.com/questions/7047618/how-to-copy-text-from-command-line-mode-in-vim |
| :tabnew \| term   | Open a new terminal in a new tab. From: https://stackoverflow.com/questions/64584698/how-to-open-a-terminal-in-new-tab-in-neovim-with-only-one-command-without-remap |
| :tcd              | Like :cd, but only set the directory for the current tab |
| Ctrl+g            | Get filename and row for current buffer |
| Ctrl+d, Ctrl+f, PgDn | Page down. In VS Code this also works in hover opened with gh and focused using shift+k |
| Ctrl+u, Ctrl+b, PgUp | Page up. In VS Code this also works in hover opened with gh  and focused using shift+k. |
| u                 | Undo |
| Ctrl+r            | Redo |

#### Explorer in Neovim/Vim

| Keyboard Shortcut | Description |
|-------------------|-------------|
| /                 | Start searching |
| r                 | Rename the designated file(s)/directory(ies) |
| R                 | Refresh |
| Ctrl+Left         | Collapse all directories in Explorer |
| zm                | Collapse all |

### VS Code

| Keyboard Shortcut | Description |
|-------------------|-------------|
| Ctrl+w m          | Maximize editor |
| Ctrl+k Ctrl+z     | Maximize editor by hiding other editor groups |
| Ctrl+k Ctrl+m     | Maximize editor by hiding other editor groups (a bit slower) |
| Ctrl+k Ctrl+w     | Maximize editor by hiding other editor groups (less reliable) |
| Ctrl+PgUp or Ctrl+h | Go to left tab |
| Ctrl+PgDn or Ctrl+l | Go to right tab |
| Ctrl+Shift+PgUp   | Move tab left |
| Ctrl+Shift+PgDn   | Move tab right |
| Alt+1..0          | Go to tab X where X is the numerical key between 1 and 0 |
| Alt+Left          | Go to previous editor in history |
| Alt+Right         | Go to newer editor in history |
| Alt+Up            | Move current line or selected lines up one row |
| Alt+Down          | Move current line or selected lines down one row |
| Ctrl+Tab          | List and switch to another tab in focused editor group |
| Alt+z             | Word wrap |
| Ctrl+w Ctrl+up, down, left, right | Move focused editor to another/new editor group |
| Ctrl+w + up, down, left, right | Move focused editor to another/new editor group |
| Ctrl+w Shift+Left or Right | Move editor group |
| Ctrl+Shift+Left or Right | Move editor to another editor group |
| Ctrl+w q          | Close focused editor, or misc. windows such as Markdown preview, Keyboard shortcuts |
| Ctrl+k w          | Close all editors in group |
| Ctrl+k z          | Enter Zen mode |
| Ctrl+ö            | Show Terminal |
| Ctrl+Shift+b      | Build default task |
| Ctrl+Shift+m      | Toggle showing Problems |
| Ctrl+Shift+u      | Toggle showing Output |
| Ctrl+Alt+Shift+m  | Maximize panel |
| Ctrl+b            | Close sidebar (Only works when sidebar is focused) |
| Ctrl+shift+e      | Focus Explorer sidebar |
| Ctrl+Shift+f      | Focus Search sidebar |
| Ctrl+Shift+o      | Go to Symbol in Editor (Outline view) |
| Shift+Alt+f       | Set to only search files inside current folder in Search sidebar |
| Ctrl+Shift+g g    | Focus Source Control sidebar |
| Ctrl+y            | [Scroll without moving cursor](https://stackoverflow.com/questions/49142401/how-to-scroll-without-moving-my-cursor-in-visual-studio-code-from-the-keyboard) up |
| Ctrl+e            | [Scroll without moving cursor](https://stackoverflow.com/questions/49142401/how-to-scroll-without-moving-my-cursor-in-visual-studio-code-from-the-keyboard) down |
| Ctrl+Shift+Enter  | In Explorer toggle selection of files |
| Shift+k           | Open hover if not opened. Focus it if opened. So press twice to open and navigate |
| Ctrl+'            | Toggle comment. First select text. If line selection is used then line comments. If block selection is used then block comment |
| Ctrl+Alt+r        | Works in Terminal. Open list of recently ran commands to select and run again. Allow searching |
| Ctrl+Shift+o      | Works in Terminal. Opens list of detected links and allows you to open selected one |
| Shift+k           | Focus hover menu, such as the one that shows when you press gh in Neovim on Python function. When in focus you can scroll in it |
| F6                | Focus next part in VS Code |
| Shift+F6          | Focus previous part in VS Code |
| Shift+F12         | Go to References |

#### Search sidebar

| Keyboard Shortcut | Description |
|-------------------|-------------|
| Ctrl+Shift+f      | Focus Search sidebar |
| Ctrl+Up           | In Search sidebar fields navigate to field above |
| Ctrl+Down         | In Search sidebar fields navigate to field below |
| F4                | Next search result |
| Shift+F4          | Previous search result |

#### Explorer sidebar

| Keyboard Shortcut | Description |
|-------------------|-------------|
| Ctrl+e            | Focus Explorer sidebar |
| Ctrl+Left         | Collapse all directories in Explorer |
| /                 | Start searching |
| up, down          | Next or previous search result after searching |
| Enter             | Open file in new editor |
| Space             | Preview file in preview editor. Uses same preview editor for all files |

#### VS Code Neovim extension

| Keyboard Shortcut | Description |
|-------------------|-------------|
| mi                | Select multiple rows with visual block to get multiple cursors at the beginning of the selection |
| Hold Alt and click| To place multiple cursors |
| z=                | Open quickfix menu for spelling corrections and refactoring |

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
The git aliases are exposed both in git and in bash and PowerShell so you can for example use `s` for `git status` like this:
#### Bash and PowerShell
```shell
g s
```
In bash you can also use:
```bash
gs
```
with all the aliases. In PowerShell this works with all aliases except the ones already set in PowerShell such as `gl` and `gp`. The `g s` format is recommended for best compatibility.

#### git
Of course traditional use of aliases in git works as well:
```shell
git s
```
