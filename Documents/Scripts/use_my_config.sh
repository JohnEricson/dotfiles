#!/bin/bash
# Script to use this users config.
# Loads the users bash config, aliases and useful
# environment variables.
# 
# Run like this:
#
# . ./use_my_config.sh

script_absolute_path=$(realpath "${BASH_SOURCE[0]}")
script_dir=$(dirname "${script_absolute_path}")
home_dir=$(echo $script_dir | sed -e 's/\(\/home\/[[:alnum:]]*\)\/.*/\1/g')

# Load config files.
source "${home_dir}/.bashrc"
source "${home_dir}/.bash_aliases"
source "${home_dir}/.environments"


# Override configs.
export PATH="${home_dir}/bin:$PATH"

# Override freedesktop.org standard dirs. Used by Neovim.
# Based on: https://neovim.io/doc/user/starting.html#standard-path
export XDG_CONFIG_HOME="${home_dir}/.config"
export XDG_DATA_HOME="${home_dir}/.local/share"

# Override Neovim/Vim config.
export VIMINIT="so ${home_dir}/.vimrc | set runtimepath^=${home_dir}/.vim"

