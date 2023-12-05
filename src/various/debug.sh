#!/usr/bin/env zsh

debugLogFile$(z39)() {
  print$(z39) "$(userHomeDir)/zZshFramework.log"
}

debugConsoleTurnON() {
  export _IS_DEBUG_ENABLED="YES"
  debugPrintEnabledStatus$(z39)
}

debugConsoleTurnOFF() {
  export _IS_DEBUG_ENABLED="NO"
  debugPrintEnabledStatus$(z39)
}

isConsoleDebugEnabled$(z39)() {
  is-substringOf-string "YES" ${_IS_DEBUG_ENABLED} && return $(yes$(z39)) || return $(no$(z39))
}

debugPrintEnabledStatus$(z39)() {
  isConsoleDebugEnabled$(z39) && print$(z39) "DEBUG is ON" || print$(z39) "DEBUG is OFF"
}

debugFuncInit-args() {
  debugCleanLogFile$(z39)
  debugLogFunc-args$(z39) ${@}
  debugEditLogFile$(z39)
}

debugLogFunc-args$(z39)() {
  local argsInfo=""
  for i in {1.."${#@[@]}"}; do
    ! isEmpty-string$(z39) ${i} && argsInfo+="<arg $i>$@[$i]</arg $i>\n"
  done
  debugLog$(z39) "Entered func: $(stacktrace-offset$(z39) 1)\n${argsInfo}"
}

debugCleanLogFile$(z39)() {
  del "$(debugLogFile$(z39))"
  debugLog$(z39) "Cleaned log"
}

debugLog$(z39)() {
  local msg="[${1} \n  stacktrace: $(stacktrace-offset$(z39) 1)]"
  filePrepareDirAt-path $(fileBasePartOf:Path $(debugLogFile$(z39)))
  print$(z39) "\n# $(date)\n$msg}" >> "$(debugLogFile$(z39))"
  isConsoleDebugEnabled$(z39) && print$(z39) "\n[${msg}\n]"
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
