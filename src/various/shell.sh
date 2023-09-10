#!/usr/bin/env zsh

_main_shell-sourceDir() {
  # debugLogFunc-args {$@}
  local srcDir="$1"
  
  isLastCommandSucceed$(zsf)() {
    if [[ $? -eq 0 ]] ;then
      return $(yes$(zsf))
    else
      return $(no$(zsf))
    fi
  }
  
}
_callAndForget-function-args _main_shell-sourceDir $(dirname $0)