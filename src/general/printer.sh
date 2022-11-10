#!/usr/bin/env zsh

_main_printer-sourceDir() {
    # debugLogFunc-args {$@}
    local srcDir="$1"

    #/* 2022-10-20 13:03:42 TODO: @VladZams: Rename to [return$(zsf)] */
    print$(zsf)() {
      _basePrintingFunction$(zsf) ${@}
    }

    printWithRedHighlights-args$(zsf)() {
      local itemsToMakeRed=(\
        "error" "Error" "ERROR" \
        "fail" "Fail" "FAIL" \
        "fatal" "Fatal" "FATAL" \
        "exception" "Exception" "EXCEPTION")
      local result=""
      for itemToPrint in ${@} ;do
        local intermediaryRslt="${itemToPrint}"
        for match in ${itemsToMakeRed} ;do
          intermediaryRslt=$(_basePrintingFunction$(zsf) -r -- ${intermediaryRslt//${match}/$fg_bold[red]${match}$reset_color})
        done
        result="${result}${intermediaryRslt}"
      done
      _basePrintingFunction$(zsf) ${result}
    }

    _basePrintingFunction$(zsf)() {
      print ${@}
    }

    printStarted-scriptName$(zsf)() {
        _print-headline-message$(zsf) "STARTED: " "$1"
    }

    printFinished-scriptName$(zsf)() {
        _print-headline-message$(zsf) "FINISHED: " "$1"
    }
    
    print-successMessage$(zsf)() {
        _isLastCommandSucceed$(zsf) && _print-headline-message$(zsf) "SUCCESS" "$1" || print-errorMessage$(zsf) "$1"
    }
    
    print-errorMessage$(zsf)() {
        _print-headline-message$(zsf) "ERROR in <$funcstack[2] <- $funcstack[3] <- $funcstack[4]>" "$1"
    }

    print-exceptionMessage$(zsf)() {
        _print-headline-message$(zsf) "EXCEPTION: " "$1"
    }

    print-warning$(zsf)() {
        _print-headline-message$(zsf) "WARNING" "$1"
    }

    _print-headline-message$(zsf)() {
        local callStack=$(_callStackMessage-index$(zsf) 4)
        local prefix=$(if isDebugEnabled ;then
                print$(zsf) "${1} [at: ${callStack}]"
            else
                print$(zsf) "${1}"
            fi)  
        local prefix="\n$prefix: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        local subject="$2"
        isEmpty:String $subject \
            && print$(zsf) "$prefix" \
            || print$(zsf) "$prefix\n$subject"
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

