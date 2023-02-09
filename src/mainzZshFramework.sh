#!/usr/bin/env zsh

# How to enable zZshFramework on Unix based system:  
#
# 1. locate or create `.zhsrc` file at your user home directory 
#
# 2. open .zshrc in any text editor and add to the end:  
#   source "<PATH_TO_THIS_FILE_DIR>/main_zZshFramework.sh"
#
#   E. g. 
#     source "/Users/JohnDoe/zZshFramework/src/main-zZshFramework.sh"
#
# 3. Reopen your terminal or relaunch ZSH 
#   Alternatively, run:  
#   source ~/.zshrc
#
# 4. Recheck zZshFramework enabled by running:  
#   version$(zsf)
#
#   Expected output:  
#       zZshFramework x.x.x.xxxxxxxx
#

#/**
#* Internal framework's identifier used to avoid conflicts in a global zsh-functions namespace
#*/
zsf() {
  local e=${?}
  print "__zsf"
  return ${e}
}

useWithCaution() {
  local e=${?}
  print "__useWithCaution"
  return ${e}
}

version$(zsf)() {
  print$(zsf) "zZshFramework 7.1.29.20221013-zzfr-zshl"  
}

_main-zZshFramework-srcDir$(zsf)() {
  _initPrivateUtils
  local srcDir=${1}
  local gs="${srcDir}/various"
  source "${gs}/import.sh"
  _import_shFilesPaths \
    "${gs}/printer" \
    "${gs}/debug" \
    "${gs}/inputReader" \
    "${gs}/beta" \
    "${gs}/path" \
    "${gs}/clipboard" \
    "${gs}/files" \
    "${gs}/stringUtils" \
    "${gs}/networking" \
    "${gs}/docker" \
    "${gs}/java" \
    "${gs}/gpg" \
    "${srcDir}/iOS/iOS_main" \
    "${srcDir}/git/gitLog" \
    "${srcDir}/git/gitHooks" \
    "${srcDir}/git/gitBasic" \
    "${srcDir}/android/android" \
    "${srcDir}/android/macOS-android" \
    "${srcDir}/homebrew/homebrew" \

  if ! isShellSupported ;then
    abortBecauseOf-reason$(zsf) "Current Shell is NOT supported. Zsh is excepted."  
  fi

  #/**
  #* In bigger files it can be handy to user editor folding/unfolding feature for blocks of code
  #* For that a function that contains just declaration of other functions is used – a so called grouping-function
  #* Each grouping-function has a name with the following prefix
  #* 
  #* E. g.
  #* ```
  #* backend$(scopeZsf)() { # the start of a folding area
  #*     backendRemoteSources() {
  #*         ...
  #*     }
  #*
  #*     backendEdit() {
  #*         ...
  #*     }
  #* }; _callAndForget_functions backend$(scopeZsf) # the end of the folding area  
  #* ```
  #*/
  scopeZsf() {
    print$(zsf) "scope__zsf"
  }
}

_initPrivateUtils() {

  #/**
  #* Logical "yes" in zZshFramework
  #*/
  yes$(zsf)() {
    print$(zsf) 0
  }

  #/**
  #* Logical "no" in zZshFramework
  #*/
  no$(zsf)() {
    print$(zsf) 20211201
  }

  #/**
  #* General error in zZshFramework
  #*/
  error$(zsf)() {
    print$(zsf) 20220516
  }

  #/**
  #* Return normally in zZshFramework
  #*/
  return$(zsf)() {
    yes$(zsf)
  }

  isShellSupported() {
    if [ -z "${ZSH_NAME}" ] ;then
      return $(errorGeneral$(zsf)) # NO
    else 
      return 0
    fi
  }

  printShellNotSupportedError() {
    printf "ERROR: Unsupported shell. Please use z-shell, aka ZSH.\n\
The easiest way to install zsh on MacOS is to run:
brew install zsh

Then run zsh and from there run 
source <PATH_TO_THIS_SCRIPT>

If you don't have brew, check https://brew.sh/

"
  }

  abortBecauseOf-reason$(zsf)() {
      print "ERROR: ${1}" 
      abort$(zsf)
  }

  isExecutedFromAnotherScript() {
    if ! isEmpty-string$(zsf) $funcstack[3] ;then
      return $(yes$(zsf))
    else
      return $(no$(zsf))
    fi
  }

  abort$(zsf)() {
      exit 1
  }

  userLibraryDir() {
      print$(zsf) "$(userHomeDir)/Library"
  }

  userPrefsDir() {
      print$(zsf) "$(userLibraryDir)/Preferences"
  }

  userHomeDir() {
      print$(zsf) "/Users/$(whoami)"
  }

  userDesktopDir() {
      print$(zsf) "$(userHomeDir)/Desktop"
  }

  userAppsDir() {
      print$(zsf) "$(userHomeDir)/Applications"
  }

  userTrashDir() {
    print$(zsf) "$(userHomeDir)/.Trash"
  }

  install$(zsf)() {
      # /* TODO: @VladZams: abstract from macOS */
      brew ${@}
  }

  source-dir() {
      print$(zsf) "$(dirname ${1})"  
  }

  edit$(zsf)() {
      "${EDITOR}" "${@}"
  }

  tempDir$(zsf)() {
      print$(zsf) "/Users/$(whoami)/.zZshFramework/temp"
  }
}

_main-zZshFramework-srcDir$(zsf) "$(dirname ${0})"  
_unset_functions _main-zZshFramework-srcDir$(zsf)