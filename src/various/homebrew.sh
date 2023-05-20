#!/usr/bin/env zsh

_main_homebrew-sourceDir() {
  # debugLogFunc-args {$@}
  local srcDir="$1"
  
  addHombrewToPath$(zsf)() {
    # echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/vladzams/.zprofile
    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/vladzams/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  }
  addHombrewToPath$(zsf)

  installBrewPackageManager() {
    if ! isCommandExist-command brew ;then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brewPackageManager tap homebrew/cask-versions
    fi
  }

  brs() { brew search ${@} }

  brewRepair() {
    del "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
    brew tap homebrew/core
  }

  brewFixLinkagePermissionIssueFor-systemUserName-systemGroupName-packageToBeLinked() {
    local frameworksDir="/usr/local/Frameworks"
    if ! isFileExistAt-path $frameworksDir ;then
      sudo mkdir "$frameworksDir" &&\
      sudo chown "$1":"$2" "${frameworksDir}"
    fi
    brew ln "${3}"
  }

  brewInfo-packages() {
    brew info ${@}
  }

  brewPackageManager() {
    installBrewPackageManager
    brew ${@}
  }

  brewUpdateAndCleanCaches() {
    brewPackageManager update-reset && brewPackageManager update
  }

  removeBrewPackageManager() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
  }

}
_callAndForget-function-args _main_homebrew-sourceDir $(dirname $0)