#!/usr/bin/env zsh

alias gr="g$(zsf) remote"
alias ggpush="g$(zsf) push origin HEAD"
alias gd="g$(zsf) diff"
alias gde="g$(zsf) difftool"
alias ga="g$(zsf) add"
alias gco="g$(zsf) checkout"  
alias gm="g$(zsf) merge"  
alias grb="g$(zsf) rebase"
alias grc="g$(zsf) rebase --continue"  
alias gs="g$(zsf) status"
alias gss="gitListStaged"
alias gcm="gitCheckoutToMaster"
alias gst="g$(zsf) stash"
alias gstl="g$(zsf) stash list | cat"
alias gb="g$(zsf) branch"
alias gba="g$(zsf) branch -a"

g$(zsf)() {
  git ${@}
}

gitConfigGPGEnableSigningByDefault() {
  git config commit.gpgSign true
}

gitConfigSet-signingKeyId$(zsf)() {
  local signingKey="$1"
  g$(zsf) config user.signingkey ${signingKey} && \
    print-successMessage$(zsf) "Key is set to: " && \
    g$(zsf) config user.signingkey
}

gitUser() {
  g$(zsf) config user.name
  g$(zsf) config user.email
}

gitCheckoutToUpdated_branch() {
  g$(zsf) checkout "$1" && ggpull
}

gitMergeCurrentBranchToShared-branch() {
  local sourceBranch="$(gitCurrentBranch)"
  local destinationBranch="$1"
  gitRebaseCurrentBranch-onBranch "$destinationBranch"
  g$(zsf) checkout "$destinationBranch"
  gm "$sourceBranch"
  ggpush || print-warning$(zsf) "Pushing to remote has NOT suceeded"
}

gitRebaseCurrentBranch-onBranch() {
    local baseBranch="$1"
    g$(zsf) checkout ${baseBranch}
    ggpull || print-warning$(zsf) "Pulling from remote has not suceeded"  
    g$(zsf) checkout -
    g$(zsf) rebase ${baseBranch} || g$(zsf) checkout - # if rebase didn't go well, we still do checkout back to the initial branch  
    gitLogLatestCommits_count 1
}

## Experimental
_gitMergeCurrentBranchIntoPrevious() {
    local currentBranch="$(gitCurrentBranch)"
    
    g$(zsf) checkout - && \
    g$(zsf) merge "$currentBranch" && \
    sysClipboardCopy-args "$currentBranch" 
}

gitListStaged() {
    g$(zsf) diff --name-status --cached | cat
}

ggpull() {
    g$(zsf) pull --rebase --no-edit origin $(gitCurrentBranch)
}

gitSshSetKey_privateKeyFile() {
    g$(zsf) config core.sshCommand "ssh -i $1"
}

gitCurrentBranch() {
    local ref
	ref=$(command g$(zsf) symbolic-ref --quiet HEAD 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]]
	then
		[[ $ret == 128 ]] && return
		ref=$(command g$(zsf) rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}

gitDiffUncommittedChanges_args() {
  g$(zsf) difftool --no-prompt ${@}
}