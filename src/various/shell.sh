#!/usr/bin/env zsh

_main_shell-sourceDir() {
  # debugLogFunc-args$(z39) {$@}
  local srcDir="$1"
  
  isLastCommandSucceed$(z39)() {
    if [[ $? -eq 0 ]] ;then
      return $(yes$(z39))
    else
      return $(no$(z39))
    fi
  }
  
}
_callAndForget-function-args _main_shell-sourceDir $(dirname $0)