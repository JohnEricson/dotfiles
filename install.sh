#!/bin/sh
# Needed by VS Code Remote - Containers extension to be able to launch dotFiles creation.
# Configure in VS Code like this:
#   "dotfiles.repository": "JohnEricson/dotFiles"

sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply JohnEricson

