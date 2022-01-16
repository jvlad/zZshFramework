#!/usr/bin/env zsh

_main_symbolicate_crash() {
    export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
    local symbolcatingTool="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

    # $symbolcatingTool $@ > mostRecentSymbolicated.md && \
    print-successMessage$(zsf)
    
    # iOSSymbolicateARM64,dSYMFile,BaseAddress,PointersToSymbolicate() {
    #     iOSSymbolicate,Arch,SYMBFile,BaseAddress,PointersToSymbolicate \
    #         arm64 "$1" "$2" ${@:3}
    # }

    # iOSSymbolicate,Arch,SYMBFile,BaseAddress,PointersToSymbolicate() {
    #     for pointer in ${@:4}; do
    #         atos -arch "$1" -o "$2" -l "$3" "$pointer"
    #     done
    # }

    _unset_functions "_main_symbolicate_crash"
}
_main_symbolicate_crash


