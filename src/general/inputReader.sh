#!/usr/bin/env zsh

argsOrPipeIn-args$(zsf)() {
  local input
  input=$(if isEmpty:String ${@} ;then \
        read -r -d '' -t 0.01 inputPipe
        print$(zsf) "${inputPipe}"
        return 1
    else
        print$(zsf) ${@}
        return 0
    fi)
  local e=$?
  print$(zsf) "${input}"
  return $e
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