#!/usr/bin/env zsh

addToPath-args() {
    for item in ${@} ;do
         export PATH=$PATH:$item
    done
}