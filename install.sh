#!/bin/sh
# Needed by VS Code Remote - Containers extension to be able to launch dotFiles creation.
# Configure in VS Code like this:
#   "dotfiles.repository": "JohnEricson/dotFiles",
#   "dotfiles.targetPath": "~/.dotfiles",
#   "dotfiles.installCommand": "~/.dotfiles/install.sh"

sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply JohnEricson

