LC_ALL=en_US.UTF-8

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


. ~/.git-prompt.sh

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=32
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=34
#Your branch is ahead of
        elif [[ "$git_status" =~ Unmerged\ paths  ]]; then
	    local ansi=31
	else    
            local ansi=33
        fi  
        echo -n '\[\e[0;33;'"$ansi"'m\]'"$(__git_ps1)"'\[\e[0m\]'
    fi
}

function _prompt_command() {
  OLDPS=PS1
  PS1="[\[\033[32m\]\w\[\033[0m\]]\[\033[0m\]\n[\D{%H:%M:%S}]`_git_prompt` \[\033[0m\]>"
  NEWPS=PS1
}

PROMPT_COMMAND=_prompt_command

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

alias cpppr=~/cpppr.sh

is_git_dirty() {
    git diff-index --quiet HEAD --
    if [ "$?" -ne "0" ]; then
        return 0;
    else
        return 1;
    fi
}

git-do-branch() {
    with_stash=0;
    if is_git_dirty; then
	with_stash=1;
        git stash
    fi
    git checkout master && git pull && git branch $1 && git checkout $1
    if [ "$with_stash" -ne "0" ]; then
        git stash pop
    fi
}

alias gitb=git-do-branch  
