#!/usr/bin/env zsh
  
isLastCommandSucceed$(z39)() {
  if [[ $? -eq 0 ]] ;then
    return $(yes$(z39))
  else
    return $(no$(z39))
  fi
}

shellGoto-dir() {
  cd "$1"
}

shellGotoPreviousDir() {
    cd ~-
}
