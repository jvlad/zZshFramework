#!/usr/bin/env zsh

_main_printer-sourceDir() {
    # debugLogFunc-args$(z39) {$@}
    local srcDir="$1"

    print$(z39)() {
      print ${@}
    }

    #/**
    #* Used for highlighting returning the value rather than printing to console
    #*/
    return$(z39)() {
      print$(z39) ${@}
    }

    printWithRedHighlights-args$(z39)() {
      local itemsToMakeRed=(\
        "error" "Error" "ERROR" "ERR" \
        "fail" "Fail" "FAIL" \
        "fatal" "Fatal" "FATAL" \
        "exception" "Exception" "EXCEPTION")
      local result=""
      for line in ${@} ;do
        local coloredSubstring="${line}"
        for match in ${itemsToMakeRed} ;do
          coloredSubstring=${coloredSubstring//${match}/$fg_bold[red]${match}$reset_color}
        done
        result+="${coloredSubstring}"
      done
      print$(z39) ${result}
    }

    _basePrintingFunction$(z39)() {
      printf ${@}
    }

    printStarted-scriptName$(z39)() {
      print-headline-message$(z39) "STARTED ${1}"
    }

    printFinished-scriptName$(z39)() {
      print$(z39) "FINISHED: " "$1"
    }
    
    printSuccessOrError-msg$(z39)() {
      isLastCommandSucceed$(z39) && print$(z39) "SUCCESS: " "$1" || print-errorMessage$(z39) "$1"
    }
    
    print-errorMessage$(z39)() {
      print$(z39) "ERROR in $(stacktrace-offset$(z39) 1)" "$1"
    }

    print-exceptionMessage$(z39)() {
      print$(z39) "EXCEPTION: " "$1"
    }

    print-warningMessage$(z39)() {
      print$(z39) "WARNING: " "$1"
    }

    print-headline-message$(z39)() {
      local prefix="${1}$(isConsoleDebugEnabled$(z39) && print$(z39) " [from: $funcstack[4]]")"
      local prefix="\n>>>>>>>>>>>>>>>>>> $prefix"
      local subject="$2"
      isEmpty-string$(z39) $subject \
        && print$(z39) "$prefix" \
        || print$(z39) "$prefix\n$subject"
    }
}
_callAndForget-function-args _main_printer-sourceDir $(dirname $0)

