#!/usr/bin/env zsh

_main_DebugShell() {

    debugTurnON() {
      export _IS_DEBUG_ENABLED="YES"
      debugPrintEnabledStatus
    }

    debugTurnOFF() {
      export _IS_DEBUG_ENABLED="NO"
      debugPrintEnabledStatus
    }

    isDebugEnabled() {
      if is-substringOf-string "YES" ${_IS_DEBUG_ENABLED}; then
        return $(yes$(zsf))
      fi
      return $(no$(zsf))
    }

    debugPrintEnabledStatus() {
        if isDebugEnabled; then
            print$(zsf) "DEBUG is ON"
        else 
            print$(zsf) "DEBUG is OFF"
        fi
    }

    debugFuncInit-args() {
      debugCacheClean
      debugLogFunc-args ${@}
      debugCacheEdit
    }

    debugLogFunc-args() {
      # if ! isDebugEnabled; then
      #     return $(error$(zsf))
      # fi
      local argsInfo=""
      for i in {1.."${#@[@]}"}; do
        argsInfo+="<arg $i>$@[$i]</arg $i>\n"
      done
      
      debugLog "DEBUG: entered func $(stacktrace-offset$(zsf) 1)\n${argsInfo}"
    }

    stacktrace-offset$(zsf)() {
      # [@arg offset] allows to exclude items from the top of the stacktrace  
      local offset=${1}
      ((offset+=2))
      local stacktrace="\n[$funcstack[${offset}]\n"
      local last=${#funcstack[@]}
      for (( i=((offset+=1)); i<=${last}; i++ )); do
        stacktrace+="  <- ${funcstack[${i}]}\n"
      done
      print "${stacktrace}]\n"
    }

    debugCacheClean() {
      del "$(debugLogFile$(zsf))"
      print$(zsf) "# `date`" >> "`debugLogFile$(zsf)`"
      print$(zsf) "Cleaned" >> "$(debugLogFile$(zsf))"
    }

    debugCacheAppendDivider() {
      if ! isDebugEnabled; then
        return $(error$(zsf))
      fi
      print$(zsf) "\n\n===========================\n===========================\n===========================" >> "$(debugLogFile$(zsf))"
    }

    debugLog() {
      if ! isDebugEnabled; then
        return $(error$(zsf))
      fi
      local cacheDir="$(debugLogFile$(zsf))"
      filePrepareDirAt-path "$(fileBasePartOf:Path "$cacheDir")"
      print$(zsf) "\n# $(date)" >> "$(debugLogFile$(zsf))"
      print$(zsf) "$@" >> "$(debugLogFile$(zsf))"
    }

    debugCacheEdit() {
      edit__zsf "$(debugLogFile$(zsf))"    
    }

    debugLogFile$(zsf)() {
      print$(zsf) "$(tempPersonalDir)/shellScriptsDebugOutput.log"
    }

}
_callAndForget_functions _main_DebugShell