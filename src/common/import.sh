#!/usr/bin/env zsh

_main_shell_import() {
    
    _callAndForget_function() {
        "$1" ${@:2}
        _unset_functions $1
    }

    _callAndForget_functions() {
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
        local fileToImport="$1.sh"
        # echo "fileToImport: $fileToImport"
        source "$fileToImport" "${@:2}"
    }
    alias _import="_import_shFile_args"

    _unset_functions() {
        for func in $@; do
            unset -f "$func" 2> /dev/null
        done
    }
}
_main_shell_import
_unset_functions _main_shell_import