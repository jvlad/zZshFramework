#!/usr/bin/env zsh

_main_homebrew-sourceDir() {
  # debugLogFunc-args {$@}
  local srcDir="$1"
  
  addHombrewToPath$(zsf)() {
    # echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/vladzams/.zprofile
    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/vladzams/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  }; addHombrewToPath$(zsf)
}
_callAndForget-function-args _main_homebrew-sourceDir $(dirname $0)