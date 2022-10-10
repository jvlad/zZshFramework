#!/usr/bin/env zsh

installBrewPackageManager() {
  if ! isCommandExist brew ;then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brewPackageManager tap homebrew/cask-versions
  fi
}

brs() { brew search ${@} }

brc() { brew cask ${@} }

brcs() { brew cask search ${@} }

brewRepair() {
  del "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
  brew tap homebrew/core
}

brewFixLinkagePermissionIssueFor-systemUserName-systemGroupName-packageToBeLinked() {
  local frameworksDir="/usr/local/Frameworks"
  if ! isFileExistAt:Path $frameworksDir ;then
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
  brew "$@"
}

brewUpdateAndCleanCaches() {
  brewPackageManager update-reset && brewPackageManager update
}

removeBrewPackageManager() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
}
