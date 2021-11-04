#!/usr/bin/env zsh

_main_feedback_printing() {

    printSuccessAdding:Message() {
        isLastCommandSucceed && print_prefix_message "SUCCESS" "$1" || printError_message "$1"
    }
    
    printError_message() {
        print_prefix_message "ERROR: " "$1"
    }

    printException_message() {
        print_prefix_message "EXCEPTION: " "$1"
    }

    print-warning() {
        print_prefix_message "WARNING" "$1"
    }

    print_prefix_message() {
        local callStack=`callStackMessage_index 4`
        isEmpty:String $callStack \
            && local prefix="$1" \
            || local prefix="$1 [at: $callStack]"  
        
        local prefix="\n$prefix: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        local subject="$2"
        isEmpty:String $subject \
            && print__zsf "$prefix" \
            || print__zsf "$prefix\n$subject\n"
    }

    callStackMessage_index() {
        ! isDebugEnabled && return 1
        
        print__zsf "$funcstack[$1]"
    }

    isLastCommandSucceed(){
        if [[ $? -eq 0 ]] ;then
            return 0
        else
            return 1
        fi
    }
}
_callAndForget_functions _main_feedback_printing