#!/usr/bin/env zsh

alias gr="git remote"
alias ggpush="git push origin HEAD"
alias gd="git diff"
alias ga="git add"
alias gco="git checkout"  
alias gm="git merge"  
alias grb="git rebase"
alias grc="git rebase --continue"  

ggpull() {
    git pull --no-edit origin `gitCurrentBranch`
}

gitCurrentBranch() {
    local ref
	ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]]
	then
		[[ $ret == 128 ]] && return
		ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}