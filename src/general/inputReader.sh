#!/usr/bin/env zsh

argsOrPipeIn-args$(zsf)() {
  local input
  input=$(if isEmpty:String ${@} ;then \
        read -r -d '' -t $(_inputWaitingTimeout$(zsf)) inputPipe
        print$(zsf) "${inputPipe}"
        return $(no$(zsf))
    else
        print$(zsf) ${@}
        return $(yes$(zsf))
    fi)
  local e=$?
  print$(zsf) "${input}"
  return $e
}

pipeInOrArgs-args$(zsf)() {
  local input=$(read -r -d '' -t $(_inputWaitingTimeout$(zsf)) inputPipe; print$(zsf) "${inputPipe}")
  if isEmpty:String ${input} ;then
    print$(zsf) ${@}
    return $(no$(zsf))
  else
    print$(zsf) ${input}
    return $(yes$(zsf))
  fi
}

_inputWaitingTimeout$(zsf)() {
  print$(zsf) 2
}