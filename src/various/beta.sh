#!/usr/bin/env zsh

_main_beta-sourceDir() {
#    debugLogFunc-args {$@}
  local srcDir="$1"

  sysWifiListNetworks() {
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
  }

  _print-fileExcludingLinesThatStartWith-character$(zsf)() {
    cat "$1" | sed -e '/^'"$2"'/d'
  }

  #/* 2023-02-08 21:10:02 TODO: @VladZams: Implementation */
  timestamp$(zsf)() {
    print-errorMessage$(zsf) "NOT implemented"
    return $(error$(zsf))
  }

  calculate() {
    print$(zsf) $((${@}))
  }
  # clcl() {
  #   calculate ${@} | sysClipboardCopyVerbose-args
  # }

  isUnixOS() {
    local OS="$(uname)"
    if [[ "${OS}" == "Linux" || "${OS}" == "Darwin" ]] ;then
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