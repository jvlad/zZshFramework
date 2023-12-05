#!/usr/bin/env zsh

argsOrPipeIn-args$(z39)() {
  local input
  input=$(if isEmpty-string$(z39) ${@} ;then \
        read -r -d '' -t $(_inputWaitingTimeout$(z39)) inputPipe
        print$(z39) "${inputPipe}"
        return $(no$(z39))
    else
        print$(z39) ${@}
        return $(yes$(z39))
    fi)
  local e=$?
  print$(z39) "${input}"
  return $e
}

#/* 2023-08-03 13:09:59 TODO: @VladZams: Consider to deprecate since it's timeout-based which isn't universably applicable/reliable */
pipeInOrArgs-args$(z39)() {
  local input=$(read -r -d '' -t $(_inputWaitingTimeout$(z39)) inputPipe; print$(z39) "${inputPipe}")
  if isEmpty-string$(z39) ${input} ;then
    print$(z39) ${@}
    return $(no$(z39))
  else
    print$(z39) ${input}
    return $(yes$(z39))
  fi
}

_inputWaitingTimeout$(z39)() {
  print$(z39) 1
}