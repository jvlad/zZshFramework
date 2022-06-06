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
      if is:SubstringContainedIn:String "YES" ${_IS_DEBUG_ENABLED}; then
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

    debugFunc:Args_array() {
        if ! isDebugEnabled; then
            return $(error$(zsf))
        fi
        local argsInfo=""
        for i in {1.."${#@[@]}"}; do
            argsInfo+="<arg $i>$@[$i]</arg $i>\n"
        done
        debugLog ">>>>>>>>>DEBUG: entered func <$funcstack[2] <- $funcstack[3] <- $funcstack[4] <- $funcstack[5]>\n$argsInfo"
    }

    debugCacheClean() {
        if ! isDebugEnabled; then
            print-errorMessage$(zsf) "Debug isn't enabled"
            return $(error$(zsf))
        fi
        del "$(debugCachePath)"
        print$(zsf) "# `date`" >> "`debugCachePath`"
        print$(zsf) "Cleaned" >> "$(debugCachePath)"
    }

    debugCacheAppendDivider() {
        if ! isDebugEnabled; then
            return $(error$(zsf))
        fi
        print$(zsf) "\n\n===========================\n===========================\n===========================" >> "$(debugCachePath)"
    }

    debugLog() {
        if ! isDebugEnabled; then
            return $(error$(zsf))
        fi
        local cacheDir="$(debugCachePath)"
        filePrepareDirAt:Path "$(fileBasePartOf:Path "$cacheDir")"
        print$(zsf) "\n# `date`" >> "`debugCachePath`"
        print$(zsf) "$@" >> "$(debugCachePath)"
    }

    debugCacheEdit() {
        edit__zsf "$(debugCachePath)"    
    }

    debugCachePath() {
        print$(zsf) "$(tempDir$(zsf))/shellScriptsDebugOutput.md"
    }

}
_callAndForget_functions _main_DebugShell