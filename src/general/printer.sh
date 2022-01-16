#!/usr/bin/env zsh

_main_printer-sourceDir() {
    # debugFunc:Args_array {$@}
    local srcDir="$1"
    
    print-successMessage$(zsf)() {
        _isLastCommandSucceed$(zsf) && _print-headline-message$(zsf) "SUCCESS" "$1" || print-errorMessage$(zsf) "$1"
    }
    
    print-errorMessage$(zsf)() {
        _print-headline-message$(zsf) "ERROR: " "$1"
    }

    print-exceptionMessage$(zsf)() {
        _print-headline-message$(zsf) "EXCEPTION: " "$1"
    }

    print-warning$(zsf)() {
        _print-headline-message$(zsf) "WARNING" "$1"
    }

    _print-headline-message$(zsf)() {
        local callStack=$(_callStackMessage-index$(zsf) 4)
        isEmpty:String $callStack \
            && local prefix="$1" \
            || local prefix="$1 [at: $callStack]"  
        
        local prefix="\n$prefix: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        local subject="$2"
        isEmpty:String $subject \
            && print$(zsf) "$prefix" \
            || print$(zsf) "$prefix\n$subject\n"
    }

    _callStackMessage-index$(zsf)() {
        ! isDebugEnabled && return 1
        
        print$(zsf) "$funcstack[$1]"
    }

    _isLastCommandSucceed$(zsf)() {
        if [[ $? -eq 0 ]] ;then
            return 0
        else
            return 1
        fi
    }
}
_callAndForget-function-args _main_printer-sourceDir $(dirname $0)

