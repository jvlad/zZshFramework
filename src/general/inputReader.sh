#!/usr/bin/env zsh

argsOrPipeIn-args$(zsf)() {
  local input=$(if isEmpty:String ${@} ;then \
        read -r -d '' -t 0.01 inputPipe
        print$(zsf) "${inputPipe}"
    else
        print$(zsf) ${@}
    fi)
  print$(zsf) "${input}"
}

pipeInOrArgs-args$(zsf)() {
  local input=$(read -r -d '' -t 0.01 inputPipe; print$(zsf) "${inputPipe}")
  if isEmpty:String ${input} ;then
    print$(zsf) ${@}
    return 1
  else
    print$(zsf) ${input}
    return 0
  fi
}