#!/usr/bin/env zsh

gr() {
  g$(z39) remote ${@}
}

gd() {
  g$(z39) diff ${@}
}

gde() {
  g$(z39) difftool ${@}
}

ga() {
  g$(z39) add ${@}
}

gco() {
  g$(z39) checkout ${@}
}
  
gm() {
  g$(z39) merge ${@}
}
  
gss() {
  gitListStaged ${@}
}

gcm() {
  gitCheckoutToMaster ${@}
}

gst() {
  g$(z39) stash ${@}
}

gstl() {
  g$(z39) stash list | cat ${@}
}

gb() {
  g$(z39) branch ${@}
}

gba() {
  g$(z39) branch -a ${@}
}


g$(z39)() {
  git ${@}
}

gitIndexDirName$(z39)() {
  print$(z39) ".git"
}

ggpush() {
  g$(z39) push --set-upstream origin HEAD ${@}
}

gitConfigGPGEnableSigningByDefault() {
  git config commit.gpgSign true
}

gitConfigSet-signingKeyId$(z39)() {
  local signingKey="$1"
  g$(z39) config user.signingkey ${signingKey} && \
    printSuccessOrError-msg$(z39) "Key is set to: " && \
    g$(z39) config user.signingkey
}

gitUser() {
  g$(z39) config user.name
  g$(z39) config user.email
}

gitCheckoutToUpdated_branch() {
  g$(z39) checkout "$1" && ggpull
}

gitMergeCurrentBranchOnto-sharedBranch-newMergedBranchName_optional() {
  local sourceBranch="$(gitCurrentBranch)"
  local baseBranch=${1}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(z39) \
    ${sourceBranch} ${baseBranch} ${3})
  g$(z39) checkout ${baseBranch}
  g$(z39) pull origin ${baseBranch} || return $(error$(z39))
  g$(z39) checkout ${sourceBranch}
  gitMergeCurrentBranchOnto-localBranch-newMergedBranchName_optional ${baseBranch} ${newMergedBranch}
}

gitMerge-sharedBranchOnto-sharedBranch-newMergedBranchName_optional() {
  local sourceBranch=${1}
  local baseBranch=${2}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(z39) \
    ${sourceBranch} ${baseBranch} ${3})
  g$(z39) checkout ${sourceBranch}  
  g$(z39) pull origin ${sourceBranch} || return $(error$(z39))
  gitMergeCurrentBranchOnto-sharedBranch-newMergedBranchName_optional ${baseBranch} ${newMergedBranch}
}

grc() { grb --continue ${@} }
grb() { g$(z39) rebase ${@} }

gitMergeCurrentBranchOnto-localBranch-newMergedBranchName_optional() {
  local sourceBranch="$(gitCurrentBranch)"
  local baseBranch=${1}
  local newMergedBranch=$(_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(z39) \
    ${sourceBranch} ${baseBranch} ${3})
  printStarted-scriptName$(z39) "Rebasing ${sourceBranch} onto ${baseBranch} and storing result in ${newMergedBranch}"
  g$(z39) checkout ${baseBranch}
  g$(z39) checkout -b ${newMergedBranch}
  g$(z39) checkout ${sourceBranch}
  g$(z39) rebase ${newMergedBranch} || gitStatus
  gitLogLatestCommits_count 1
  g$(z39) checkout ${newMergedBranch}
  g$(z39) merge ${sourceBranch}
}

gs() {
  gitStatus ${@}
}; gitStatus() {
  g$(z39) status ${@}
}

_nameForNewBranchAfterMerge-sourceBranch-baseBranch-customNewName_optional$(z39)() {
  local sourceBranch=${1}
  local baseBranch=${2}
  local customNewName_optional=${3}
  if ! isEmpty-string$(z39) ${customNewName_optional} ;then
    print$(z39) ${customNewName_optional}
  else
    # newMergedBranch="${merged}-${sourceBranch}-on-${baseBranch}-$(timestamp$(z39))"
    print$(z39) "merged-${sourceBranch}-__on__-${baseBranch}"
  fi
}

gitListStaged() {
    g$(z39) diff --name-status --cached | cat
}

ggpull() {
    g$(z39) pull --rebase --no-edit origin $(gitCurrentBranch)
}

gitSshSetKey_privateKeyFile() {
    g$(z39) config core.sshCommand "ssh -i $1"
}

gitCurrentBranch() {
  local ref=$(g$(z39) symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ $ret != 0 ]] ;then
		[[ $ret == 128 ]] && return
		ref=$(g$(z39) rev-parse --short HEAD 2> /dev/null) || return
	fi
	echo ${ref#refs/heads/}
}

gitDiffUncommittedChanges_args() {
  g$(z39) difftool --no-prompt ${@}
}