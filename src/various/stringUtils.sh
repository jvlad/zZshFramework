#!/usr/bin/env zsh

_main_string_manipulations() {
    
    trimEndSpaces() {
        sed 's/ *$//g'
    }

    is-substringOf-string() {
      if test "${2#*$1}" != "$2" ;then
        return $(yes$(zsf))
      else
        return $(no$(zsf))
      fi
    }

    is-stringStartsWith-prefix() {
      [[ ${1} = ${2}* ]] && return $(yes$(zsf)) || return $(no$(zsf))
    }

    is-stringEndsWith-postfix() {
      [[ ${1} = *${2} ]] && return $(yes$(zsf)) || return $(no$(zsf))
    }

    is-stringEqualTo-string() {
      [[ ${1} = ${2} ]] && return $(yes$(zsf)) || return $(no$(zsf))
    }

    isEmpty-string$(zsf)() {
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