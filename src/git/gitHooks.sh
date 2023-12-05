#!/usr/bin/env zsh

_main_gitHooks() {

    gitRepoDirName() {
        print$(z39) ".git"
    }
    
    gitHookAddBranchNameInsertionHookToCurrentRepo() {
        if ! isFileExistAt-path ".git" ;then
            print-errorMessage$(z39) "Running NOT within git_repo directory"
            return 1
        fi
        fileCopy-source-destination "$srcDir__zsf/git/hooks/commit-msg" "$(gitRepoDirName)/hooks/"
    }
}
_callAndForget_functions _main_gitHooks