# From https://gist.github.com/mwhite/6887990
#
# For this to work you should define alises in your ~/.gitconfig file.

# From https://github.com/scop/bash-completion/issues/278#issuecomment-1116456586
source /usr/share/bash-completion/completions/git

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `git --list-cmds=alias`; do
    # Greate bash aliases named g* for all my git aliases.
    alias g$al="git $al"

    # Setup auto completion for my git aliases.
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_func && __git_complete g$al $complete_func
done


# Make alias gbd only return local branches.
_gbd_complete() {
    # Get the current word being completed
    local cur=${COMP_WORDS[COMP_CWORD]}
    # Get a list of local branches using `git branch` and remove the '*' character for the current branch
    local branches=$(git branch | sed 's/^\*//')
    # Perform completion using the list of branches
    COMPREPLY=($(compgen -W "$branches" -- "$cur"))
}
complete -F _gbd_complete gbd
