#!/usr/bin/env zsh

debugLogFile$(z39)() {
  print$(z39) "$(userHomeDir)/.zZshFramework.log"
}

debugConsoleTurnON() {
  export $(_debugConsoleFlag$(z39))="YES"
  debugPrintEnabledStatus$(z39)
}

debugConsoleTurnOFF() {
  export $(_debugConsoleFlag$(z39))="NO"
  debugPrintEnabledStatus$(z39)
}

isDebugConsoleEnabled$(z39)() {
  is-substringOf-string "YES" ${(P)$(_debugConsoleFlag$(z39))} && return $(yes$(z39)) || return $(no$(z39))
}

debugPrintEnabledStatus$(z39)() {
  isDebugConsoleEnabled$(z39) && print$(z39) "DEBUG is ON" || print$(z39) "DEBUG is OFF"
}

debugLogFunc-args$(z39)() {
  local argsInfo=""
  for i in {1.."${#@[@]}"}; do
    ! isEmpty-string$(z39) ${@[$i]} && argsInfo+="[arg $i [${@[$i]}]]\n"
  done
  debugLog-offset-msg$(z39) 1 "Entered func [$funcstack[2]]\n${argsInfo}"
}

debugCleanLogFile$(z39)() {
  fileMoveToTrash-filePaths "$(debugLogFile$(z39))"
  debugLog$(z39) "Cleaned log"
}

debugLog-offset-msg$(z39)() {
  local msg="${@:2}\n  stacktrace: $(stacktrace-offset$(z39) $((${1}+1)))"
  filePrepareDirAt-path $(fileBasePartOf:Path $(debugLogFile$(z39)))
  print$(z39) "\n[# $(date)\n${msg}]" >> "$(debugLogFile$(z39))"
  isDebugConsoleEnabled$(z39) && print$(z39) "\n[${msg}\n]"
}

debugLog$(z39)() {
  debugLog-offset-msg$(z39) 1 ${@}
}

stacktrace-offset$(z39)() {
  local offset=${1}
  ((offset+=2))
  local stacktrace="\n  [$funcstack[${offset}]"
  if true ;then
    local last=${#funcstack[@]}
    for (( i=((offset+=1)); i<=${last}; i++ )); do
      stacktrace+="\n    <- ${funcstack[${i}]}"
    done
  fi
  print "${stacktrace}]\n"
}

debugEditLogFile$(z39)() {
  edit$(z39) "$(debugLogFile$(z39))"    
}

_debugConsoleFlag$(z39)() {
  print$(z39) "_debugConsoleFlagValue$(z39)"
}