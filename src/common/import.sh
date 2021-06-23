#!/usr/bin/env zsh

_main_shellImport() {
    
    _callAndForget_function_argsArray() {
        "$1" ${@:2}
        _unset_functions $1
    }

    _callAndForget_functions() {
        # debugFunc:Args_array "$@"
        for func in $@; do
            "$func"
        done
        _unset_functions $@
    }

    _import_shFilesPaths() {
        for file in ${@}; do
            _import_shFile_args "$file"
        done
    }

    _import_shFile_args() {
        # debugFunc:Args_array "$@"
        local fileToImport="$1.sh"
        # echo "fileToImport: $fileToImport"
        source "$fileToImport" "${@:2}"
    }
    alias _import="_import_shFile_args"

    _unset_functions() {
        for func in $@; do
            # print "unsetting func $func"
            unset -f "$func" 2> /dev/null
        done
    }
}
_main_shellImport
_unset_functions _main_shellImport