#!/usr/bin/env zsh

alias gr="g$(zsf) remote"
alias ggpush="g$(zsf) push origin HEAD"
alias gd="g$(zsf) diff"
alias gde="g$(zsf) difftool"
alias ga="g$(zsf) add"
alias gco="g$(zsf) checkout"  
alias gm="g$(zsf) merge"  
grc() { g$(zsf) rebase --continue ${@} }
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

gitMergeCurrentBranchOnto-sharedBranch-newMergedBranchName_optional() {
  local sourceBranch="$(gitCurrentBranch)"
  local baseBranch=${1}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(zsf) \
    ${sourceBranch} ${baseBranch} ${3})
  g$(zsf) checkout ${baseBranch}
  g$(zsf) pull origin ${baseBranch} || return $(error$(zsf))
  g$(zsf) checkout ${sourceBranch}
  gitMergeCurrentBranchOnto-localBranch-newMergedBranchName_optional ${baseBranch} ${newMergedBranch}
}

gitMerge-sharedBranchOnto-sharedBranch-newMergedBranchName_optional() {
  local sourceBranch=${1}
  local baseBranch=${2}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(zsf) \
    ${sourceBranch} ${baseBranch} ${3})
  g$(zsf) checkout ${sourceBranch}  
  g$(zsf) pull origin ${sourceBranch} || return $(error$(zsf))
  gitMergeCurrentBranchOnto-sharedBranch-newMergedBranchName_optional ${baseBranch} ${newMergedBranch}
}

grb() { 
  gitMergeCurrentBranchOnto-localBranch-newMergedBranchName_optional ${@} 
}; gitMergeCurrentBranchOnto-localBranch-newMergedBranchName_optional() {
  local sourceBranch="$(gitCurrentBranch)"
  local baseBranch=${1}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(zsf) \
    ${sourceBranch} ${baseBranch} ${3})
  printStarted-scriptName$(zsf) "Rebasing ${sourceBranch} onto ${baseBranch} and storing result in ${newMergedBranch}"
  g$(zsf) checkout ${baseBranch}
  g$(zsf) checkout -b ${newMergedBranch}
  g$(zsf) checkout ${sourceBranch}
  g$(zsf) rebase ${newMergedBranch} || return $(error$(zsf))
  gitLogLatestCommits_count 1
  g$(zsf) checkout ${newMergedBranch}
  g$(zsf) merge ${sourceBranch}
}

_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(zsf)() {
  local sourceBranch=${1}
  local baseBranch=${2}
  local customNewName_optional=${3}
  if ! isEmpty-string$(zsf) ${customNewName_optional} ;then
    print$(zsf) ${customNewName_optional}
  else
    # newMergedBranch="${merged}-${sourceBranch}-on-${baseBranch}-$(timestamp$(zsf))"
    print$(zsf) "merged-${sourceBranch}-__on__-${baseBranch}"
  fi
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
  local ref=$(g$(zsf) symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ $ret != 0 ]] ;then
		[[ $ret == 128 ]] && return
		ref=$(g$(zsf) rev-parse --short HEAD 2> /dev/null) || return
	fi
	echo ${ref#refs/heads/}
}

gitDiffUncommittedChanges_args() {
  g$(zsf) difftool --no-prompt ${@}
}