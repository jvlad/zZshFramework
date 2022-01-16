#!/usr/bin/env zsh

_main_shellImport() {
    
    _callAndForget-function-args() {
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
        # debugFunc:Args_array "$@"
        for file in ${@}; do
            _import_shFile_args "$file"
        done
    }

    _importFrom-parentDir-shFilesNames() {
        # debugFunc:Args_array "$@"   
        for file in ${@:2} ;do
            _import_shFilesPaths ${1}/${file}
        done
    }

    fileMakeExecutable-filePaths() {
        chmod +x ${@}
    }

    _import_shFile_args() {
        local fileToImport="$1.sh"
        fileMakeExecutable-filePaths ${fileToImport}
        source "$fileToImport" "${@:2}"
    }
    alias _import="_import_shFile_args"

    #/* 2021-12-01 12:57:32 TODO: @DexHo: rename to _unset_functions$(zsf) across all the framework */
    _unset_functions() {
        for func in $@; do
            # print$(zsf) "unsetting func $func"
            unset -f "$func" 2> /dev/null
        done
    }
}
_main_shellImport
_unset_functions _main_shellImport