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
    alias g$al="git $al"
    
    complete_func=_git_$(git --list-cmds=alias $al)
    function_exists $complete_func && __git_complete g$al $complete_func
done

