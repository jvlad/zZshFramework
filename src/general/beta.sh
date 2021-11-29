#!/usr/bin/env zsh

_main_beta-sourceDir() {
#    debugFunc:Args_array {$@}
    local srcDir="$1"

    isUnixOS() {
        local OS="$(uname)"
        if [[ "${OS}" == "Linux" || "${OS}" == "Darwin" ]] ;then
            return 0
        else 
            return 1
        fi
    }

    isFileExistAt-path() {
        if [[ -a $1 ]] ;then
            return 0
        else
            return 1
        fi
    }

    #/**
    #* https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash/9964890
    #*/
    isEmpty-file() {
        if [[ -s $1 ]] ;then
            return 1 #NO
        else 
            return 0 #YES
        fi
    }

    abortBecauseOf-reason() {
        print-error $1
        exit 1
    }
}
_callAndForget_functions _main_beta-sourceDir $(dirname $0)