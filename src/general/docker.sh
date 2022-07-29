#!/usr/bin/env zsh

_main_docker-sourceDir() {
    # debugLogFunc-args {$@}
    local srcDir="$1"
    
    alias dok="docker"

    dokListContainers() {
        dok container ls -a
    }
    
}
_callAndForget-function-args _main_docker-sourceDir $(dirname $0)