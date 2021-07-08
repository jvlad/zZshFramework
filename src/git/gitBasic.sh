#!/usr/bin/env zsh

alias gr="git remote"
alias ggpush="git push origin HEAD"
alias gd="git diff"
alias ga="git add"
alias gco="git checkout"  
alias gm="git merge"  
alias grb="git rebase"
alias grc="git rebase --continue"  
alias gs="git status"
alias gss="gitListStaged"
alias gcm="gitCheckoutToMaster"
alias gst="git stash"
alias gstl="git stash list | cat"

gitCheckoutToMaster() {
    git checkout master && ggpull
}

## Experimental
gitRebaseOnMaster() {
    _gitRebaseCurrentBranch_onBranch "master"
}

## Experimental
_gitRebaseCurrentBranch_onBranch() {
    local baseBranch="$1"
    git checkout "$baseBranch"
    ggpull && \
    git checkout - && \
    git rebase "$baseBranch" || git checkout - # if rebase didn't go well, we still checkout back to the initial branch  
    gitLogLatestCommits_count 1
}

## Experimental
_gitMergeCurrentBranchIntoPrevious() {
    local currentBranch="`gitCurrentBranch`"
    
    git checkout - && \
    git merge "$currentBranch" && \
    sysClipboardCopy:Arg_array "$currentBranch" 
}

gitListStaged() {
    git diff --name-status --cached | cat
}

ggpull() {
    git pull --rebase --no-edit origin `gitCurrentBranch`
}

gitSshSetKey_privateKeyFile() {
    git config core.sshCommand "ssh -i $1"
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