#!/usr/bin/env zsh

_main_docker-sourceDir() {
    # debugFunc:Args_array {$@}
    local srcDir="$1"
    
    alias dok="docker"

    dokListContainers() {
        dok container ls -a
    }
    
}
_callAndForget-function-args _main_docker-sourceDir $(dirname $0)