#!/usr/bin/env zsh

_main_string_manipulations() {
    
    trimEndSpaces() {
        sed 's/ *$//g'
    }

    is:SubstringContainedIn:String() {
      if test "${2#*$1}" != "$2" ;then
        return $(yes$(zsf))
      else
        return $(no$(zsf))
      fi
    }

    is-stringStartsWith-prefix() {
      if [[ ${1} = ${2}* ]];then
        return $(yes$(zsf))
      else
        return $(no$(zsf))
      fi
    }

    is-stringEqualTo-string() {
        if [ "$1" = "$2" ]; then
            return $(yes$(zsf))
        else
            return $(no$(zsf))
        fi
    }

    isEmpty:String() {
        if [[ -z $1 ]] ;then
            return $(yes$(zsf))
        else
            return $(no$(zsf))
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