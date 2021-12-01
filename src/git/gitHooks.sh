#!/usr/bin/env zsh

_main_gitHooks() {

    gitRepoDirName() {
        print$(zsf) ".git"
    }
    
    gitHookAddBranchNameInsertionHookToCurrentRepo() {
        if ! isFileExistAt:Path ".git" ;then
            printError_message "Running NOT within git_repo directory"
            return 1
        fi
        fileCopy_source_destination "$srcDir__zsf/git/hooks/commit-msg" "`gitRepoDirName`/hooks/"
    }
}
_callAndForget_functions _main_gitHooks