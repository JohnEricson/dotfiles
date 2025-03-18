#!/bin/sh
# Needed by VS Code Remote - Containers extension to be able to launch dotFiles creation.
# Configure in VS Code like this:
#   "dotfiles.repository": "JohnEricson/dotFiles",
#   "dotfiles.targetPath": "~/.dotfiles",
#   "dotfiles.installCommand": "~/.dotfiles/install.sh"

# Make sure we are in home directory. 
cd ~

# Install dotfiles.
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply JohnEricson

# Refresh shell with our new config.
. ~/.bashrc

