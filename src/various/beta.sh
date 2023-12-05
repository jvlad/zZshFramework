#!/usr/bin/env zsh

_main_beta-sourceDir() {
#    debugLogFunc-args$(z39) {$@}
  local srcDir="$1"

  sysWifiListNetworks() {
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
  }

  _print-fileExcludingLinesThatStartWith-character$(z39)() {
    cat "$1" | sed -e '/^'"$2"'/d'
  }

  #/* 2023-02-08 21:10:02 TODO: @VladZams: Implementation */
  timestamp$(z39)() {
    print-errorMessage$(z39) "NOT implemented"
    return $(error$(z39))
  }

  calculate() {
    print$(z39) $((${@}))
  }
  # clcl() {
  #   calculate ${@} | sysClipboardCopyVerbose-args
  # }

  isUnixOS() {
    local OS="$(uname)"
    if [[ "${OS}" == "Linux" || "${OS}" == "Darwin" ]] ;then
      return $(yes$(z39))
    else
      return $(no$(z39))
    fi
  }

  #/**
  #* https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash/9964890
  #* 2021-12-01 12:03:02 TODO: @DexHo:  Unit test */
  #*/ 
  isEmpty-file() {
    if [[ -s $1 ]] ;then
      return $(no$(z39))
    else 
      return $(yes$(z39))
    fi
  }

  isCommandExist-command() {
    if ${1} --version > /dev/null 2>&1 ;then
      return $(yes$(z39))
    else
      return $(no$(z39))
    fi
  }

  askUserFor-file() {
    local requiredFile="$1"
    while ! [[ -a ${requiredFile} ]] ;do
      print$(z39) "Add [${requiredFile}] file and press Enter to continue..."
      read -k1 -s
    done
  }

  sysProcessId() {
    print$(z39) \[$$\]
  #   # ps  -ef | grep $$ | grep -v grep
    # print without parent-process ID
  }
}
_callAndForget-function-args _main_beta-sourceDir $(dirname $0)