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
        if is:SubstringContainedIn:String "NO" "$_IS_DEBUG_ENABLED"; then
            return 1
        elif is:SubstringContainedIn:String "YES" "$_IS_DEBUG_ENABLED"; then
            return 0
        fi
        return 1
    }

    debugPrintEnabledStatus() {
        if isDebugEnabled; then
            print__zsf "DEBUG is ON"
        else 
            print__zsf "DEBUG is OFF"
        fi
    }

    debugFunc:Args_array() {
        if ! isDebugEnabled; then
            printError_message "Debug isn't enabled"
            return 1
        fi
        local argsInfo=""
        for i in {1.."${#@[@]}"}; do
            argsInfo+="<arg $i>$@[$i]</arg $i>\n"
        done
        debugLog ">>>>>>>>>DEBUG: entered func <$funcstack[2] <- $funcstack[3] <- $funcstack[4] <- $funcstack[5]>\n$argsInfo"
    }

    debugCacheClean() {
        if ! isDebugEnabled; then
            printError_message "Debug isn't enabled"
            return 1
        fi
        del "`debugCachePath`"
        print__zsf "# `date`" >> "`debugCachePath`"
        print__zsf "Cleaned" >> "`debugCachePath`"
    }

    debugCacheAppendDivider() {
        if ! isDebugEnabled; then
            printError_message "Debug isn't enabled"
            return 1
        fi
        print__zsf "\n\n===========================\n===========================\n===========================" >> "`debugCachePath`"
    }

    debugLog() {
        if ! isDebugEnabled; then
            printError_message "Debug isn't enabled"
            return 1
        fi
        local cacheDir="`debugCachePath`"
        filePrepareDirAt:Path "`fileBasePartOf:Path "$cacheDir"`"
        print__zsf "\n# `date`" >> "`debugCachePath`"
        print__zsf "$@" >> "`debugCachePath`"
    }

    debugCacheEdit() {
        edit__zsf "`debugCachePath`"    
    }

    debugCachePath() {
        print__zsf "`tempDir__zsf`/shellScriptsDebugOutput.md"
    }

}
_callAndForget_functions _main_DebugShell