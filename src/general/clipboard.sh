#!/usr/bin/env zsh

_main_clipboard() {

    sysClipboardCopyVerbose_argsArray() {
        sysClipboardCopy:Arg_array "$@"
        print$(zsf) "$@\nis copied to clipboard"
    }
    
    sysClipboardCopy:Arg_array() {
        local content="$@"
        sysClipboardCopy_isRemovingLinebreaks_args false "$content"
    }

    sysClipboardCopyRemovingLinebreaks_args() {
        local content="$@"
        sysClipboardCopy_isRemovingLinebreaks_args true "$content"
    }

    sysClipboardCopy_isRemovingLinebreaks_args() {
        local isRemovingLinebreaks="$1"
        local file="${@:2}"
        if [[ $OSTYPE == darwin* ]] ;then
            if [[ -z $file ]]; then
                pbcopy
            else
                if $isRemovingLinebreaks ;then
                    echo "$file" | tr -d '\n' | pbcopy
                else
                    echo "$file" | pbcopy
                fi
            fi
        elif [[ $OSTYPE == cygwin* ]] ;then
            if [[ -z $file ]]; then
                echo > /dev/clipboard
            else
                echo "$file" > /dev/clipboard
            fi
        else
            if (( $+commands[xclip] )) ;then
            if [[ -z $file ]]; then
                xclip -in -selection clipboard
            else
                xclip -in -selection clipboard "$file"
            fi
            elif (( $+commands[xsel] )) ;then
            if [[ -z $file ]]; then
                xsel --clipboard --input
            else
                echo "$file" | xsel --clipboard --input
            fi
            else
                print$(zsf) "systemCopyToClipboard: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
            return 1
            fi
        fi
    }
}
_callAndForget_functions _main_clipboard