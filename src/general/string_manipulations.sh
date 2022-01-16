#!/usr/bin/env zsh

_main_string_manipulations() {
    
    trimEndSpaces() {
        sed 's/ *$//g'
    }

    is:SubstringContainedIn:String() {
        if test "${2#*$1}" != "$2" ;then
            return 0    # $substring is in $string
        else
            return 1    # $substring is not in $string
        fi
    }

    isStringEqualTo:String() {
        if [ "$1" = "$2" ]; then
            return 0
        else
            return 1
        fi
    }

    isEmpty:String() {
        if [[ -z $1 ]] ;then
            return 0
        else
            return 1
        fi
    }

    # filterNotIncludingAfter_matchingString() {
    #     sed -e '/'"$1"'/,$d'
    # }

    # filterLinesThatStartWith_commentChar() {
    #     sed -e '/^'"$1"'/d'
    # }
}
_callAndForget_functions _main_string_manipulations