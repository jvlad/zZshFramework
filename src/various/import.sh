#!/usr/bin/env zsh

_callAndForget-function-args() {
    "$1" ${@:2}
    _unset_functions $1
}

_callAndForget_functions() {
    # debugLogFunc-args$(z39) "$@"
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

_importFrom-dir-shFileNames() {
  for file in ${@:2} ;do
    _import_shFilesPaths ${1}/${file}
  done
}

fileMakeExecutable-filePaths() {
    chmod +x ${@}
}

_import_shFile_args() {
  local fileToImport="${1}.sh"
  fileMakeExecutable-filePaths ${fileToImport}
  source "${fileToImport}" "${@:2}"
}

#/* 2021-12-01 12:57:32 TODO: @DexHo: rename to _unset_functions$(z39) across all the framework */
_unset_functions() {
  for func in $@; do
    unset -f "$func" 2> /dev/null
  done
}

shellAddToPath-paths$(z39)() {
  for _path in ${@}; do
    export PATH="${_path}:$PATH"
  done
}