#!/usr/bin/env zsh

_main_beta-sourceDir() {
#    debugLogFunc-args {$@}
  local srcDir="$1"

  _print-fileExcludingLinesThatStartWith-character$(zsf)() {
    cat "$1" | sed -e '/^'"$2"'/d'
  }

  isUnixOS() {
    local OS="$(uname)"
    if [[ "${OS}" == "Linux" || "${OS}" == "Darwin" ]] ;then
      return $(yes$(zsf))
    else
      return $(no$(zsf))
    fi
  }

  #* 2021-12-01 12:03:02 TODO: @DexHo:  Unit test */
  isFileExistAt-path() {
    if [[ -a $1 ]] ;then
      return $(yes$(zsf))
    else
      return $(no$(zsf))
    fi
  }

  #/**
  #* https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash/9964890
  #* 2021-12-01 12:03:02 TODO: @DexHo:  Unit test */
  #*/ 
  isEmpty-file() {
    if [[ -s $1 ]] ;then
      return $(no$(zsf))
    else 
      return $(yes$(zsf))
    fi
  }

  isCommandExist-command() {
    if ${1} --version > /dev/null 2>&1 ;then
      return $(yes$(zsf))
    else
      return $(no$(zsf))
    fi
  }

  sysProcessId() {
    echo \[$$\]
  #   # ps  -ef | grep $$ | grep -v grep
    # print without parent-process ID
  }
}
_callAndForget-function-args _main_beta-sourceDir $(dirname $0)