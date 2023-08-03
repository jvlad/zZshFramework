#!/usr/bin/env zsh

argsOrPipeIn-args$(zsf)() {
  local input
  input=$(if isEmpty-string$(zsf) ${@} ;then \
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

#/* 2023-08-03 13:09:59 TODO: @VladZams: Consider to deprecate since it's timeout based which isn't universably applicable/reliable */
pipeInOrArgs-args$(zsf)() {
  local input=$(read -r -d '' -t $(_inputWaitingTimeout$(zsf)) inputPipe; print$(zsf) "${inputPipe}")
  if isEmpty-string$(zsf) ${input} ;then
    print$(zsf) ${@}
    return $(no$(zsf))
  else
    print$(zsf) ${input}
    return $(yes$(zsf))
  fi
}

_inputWaitingTimeout$(zsf)() {
  print$(zsf) 1
}