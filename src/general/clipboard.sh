#!/usr/bin/env zsh

_main_clipboard() {

    sysClipboardCopyVerbose_argsArray() {
      local input=$(argsOrPipeIn-args$(zsf) ${@})
      if isEmpty:String ${input} ;then
        return 0
      else
        sysClipboardCopy:Arg_array ${input}
        print-successMessage$(zsf) "${input}\nis copied to clipboard"
      fi
    }
    alias ccl="sysClipboardCopyVerbose_argsArray"
    
    sysClipboardCopy:Arg_array() {
        local input=$(argsOrPipeIn-args$(zsf) ${@})
        sysClipboardCopy_isRemovingLinebreaks_args false "${input}"
    }

    sysClipboardCopyRemovingLinebreaks_args() {
        local input=$(argsOrPipeIn-args$(zsf) ${@})
        sysClipboardCopy_isRemovingLinebreaks_args true "${input}"
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