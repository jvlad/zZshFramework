#!/usr/bin/env zsh

_main_string_manipulations() {
    
    trimEndSpaces() {
        sed 's/ *$//g'
    }

    is-substringOf-string() {
      if test "${2#*$1}" != "$2" ;then
        return $(yes$(z39))
      else
        return $(no$(z39))
      fi
    }

    is-stringStartsWith-prefix() {
      [[ ${1} = ${2}* ]] && return $(yes$(z39)) || return $(no$(z39))
    }

    is-stringEndsWith-postfix() {
      [[ ${1} = *${2} ]] && return $(yes$(z39)) || return $(no$(z39))
    }

    is-stringEqualTo-string() {
      [[ ${1} = ${2} ]] && return $(yes$(z39)) || return $(no$(z39))
    }

    isEmpty-string$(z39)() {
        if [[ -z $1 ]] ;then
            return $(yes$(z39))
        else
            return $(no$(z39))
        fi
    }

    # filterNotIncludingAfter-spitterStr() {
    #     sed -e '/'"$1"'/,$d'
    # }

    # filterLinesThatStartWith-prefixStr() {
    #     sed -e '/^'"$1"'/d'
    # }
}
_callAndForget_functions _main_string_manipulations