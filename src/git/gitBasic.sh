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

gitCheckoutToMaster() {
    git checkout master && ggpull
}

## Experimental
gitRebaseOnMaster() {
    _gitRebaseCurrentBranch_onBranch "master" || git checkout -
}

## Experimental
_gitRebaseCurrentBranch_onBranch() {
    local branchToRebase="`gitCurrentBranch`"
    local baseBranch="$1"
    git checkout "$baseBranch"
    _gitRebaseOnCurrentBranchFrom_branchToRebase "$branchToRebase"
}

## Experimental
_gitRebaseOnCurrentBranchFrom_branchToRebase() {
    local branchToRebase="$1"
    local currentBranch="`gitCurrentBranch`"
    
    ggpull && \
    git checkout "$branchToRebase" && \
    ggpull && \
    git rebase "$currentBranch"
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