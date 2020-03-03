#!/usr/bin/env zsh

_main_clipboard() {
    
    sysClipboardCopy:Arg_array() {
        local file="$@"
        if [[ $OSTYPE == darwin* ]] ;then
            if [[ -z $file ]]; then
                pbcopy
            else
                echo $file | pbcopy
            fi
        elif [[ $OSTYPE == cygwin* ]] ;then
            if [[ -z $file ]]; then
                echo > /dev/clipboard
            else
                echo $file > /dev/clipboard
            fi
        else
            if (( $+commands[xclip] )) ;then
            if [[ -z $file ]]; then
                xclip -in -selection clipboard
            else
                xclip -in -selection clipboard $file
            fi
            elif (( $+commands[xsel] )) ;then
            if [[ -z $file ]]; then
                xsel --clipboard --input
            else
                echo "$file" | xsel --clipboard --input
            fi
            else
                print__zsf "systemCopyToClipboard: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
            return 1
            fi
        fi
    }
}
_callAndForget_function _main_clipboard