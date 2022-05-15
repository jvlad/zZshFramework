#!/usr/bin/env zsh

argsOrPipeIn-args$(zsf)() {
  local input=$(if isEmpty:String ${@} ;then \
        read inputPipe
        print$(zsf) ${inputPipe}
    else
        print$(zsf) ${@}
    fi)
  print$(zsf) "${input}"
}