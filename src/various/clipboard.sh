#!/usr/bin/env zsh

sysClipboardCopyVerbose-args() {
  local input=$(argsOrPipeIn-args$(z39) ${@})
  if isEmpty-string$(z39) ${input} ;then
    return 0
  else
    sysClipboardCopyRemovingLinebreaks-args "${input}"
    printSuccessOrError-msg$(z39) "${input}\nis copied to clipboard"
  fi
}

sysClipboardCopy-args() {
    local input=$(argsOrPipeIn-args$(z39) ${@})
    sysClipboardCopy-isRemovingLinebreaks-args false "${input}"
}

sysClipboardCopyRemovingLinebreaks-args() {
    local input=$(argsOrPipeIn-args$(z39) ${@})
    sysClipboardCopy-isRemovingLinebreaks-args true "${input}"
}

sysClipboardCopy-isRemovingLinebreaks-args() {
    local isRemovingLinebreaks="$1"
    local file="${@:2}"
    if [[ $OSTYPE == darwin* ]] ;then
      if [[ -z $file ]]; then
        pbcopy
      else
        if $isRemovingLinebreaks ;then
          print$(z39) "$file" | tr -d '\n' | pbcopy
        else
          print$(z39) "$file" | pbcopy
        fi
      fi
    elif [[ $OSTYPE == cygwin* ]] ;then
      if [[ -z $file ]]; then
        print$(z39) > /dev/clipboard
      else
        print$(z39) "$file" > /dev/clipboard
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
          print$(z39) "$file" | xsel --clipboard --input
        fi
      else
        print$(z39) "systemCopyToClipboard: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
        return 1
      fi
    fi
}