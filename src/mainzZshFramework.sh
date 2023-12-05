#!/usr/bin/env zsh
## 
# How to import zZshFramework to Zsh on a Unix-based system:  
#
# 1. locate or create `.zhsrc` file at your user-home dir
#
# 2. open .zshrc in any text editor and add to the end:  
#   source "${PATH_TO_THIS_DIR}/mainzZshFramework.sh"
#
#   E. g. 
#     source "/Users/${your-user-name}/zZshFramework/src/mainzZshFramework.sh"
#
# 3. Reopen your terminal or relaunch Zsh. Alternatively, run:  
#   source ~/.zshrc
#
# 4. Recheck zZshFramework imported by running:  
#   version$(z39)
#
#   Expected output:  
#       zZshFramework x.x.x.xxxxxxxx

z39() {
## Framework-namespace identifier, used as function-name postfix to avoid conflicts in 
# a global zsh-functions namespace
  
  local e=${?}
  print "__zsf"
  return ${e}
}

version$(z39)() {
  print$(z39) "zZshFramework 8.1.30.20231205"  
}

_main-zZshFramework-srcDir$(z39)() {
  _initPrivateUtils
  ! isShellSupported && abortBecauseOf-reason-timeoutSec$(z39) "Current shell is NOT supported. This framework runs properly on zsh only." 5
  local srcDir=${1}
  local v="${srcDir}/various"
  source "${v}/import.sh"
  _import_shFilesPaths \
    "${v}/printer" \
    "${v}/debug" \
    "${v}/inputReader" \
    "${v}/beta" \
    "${v}/path" \
    "${v}/clipboard" \
    "${v}/files" \
    "${v}/stringUtils" \
    "${v}/networking" \
    "${v}/docker" \
    "${v}/java" \
    "${v}/gpg" \
    "${v}/homebrew" \
    "${v}/shell" \
    "${v}/iOS" \
    "${srcDir}/git/gitLog" \
    "${srcDir}/git/gitHooks" \
    "${srcDir}/git/gitBasic" \
    "${srcDir}/android/android" \
    "${srcDir}/android/macOS-android" \
  
}

_initPrivateUtils() {
  
  yes$(z39)() {
  ## Logical "yes"
    
    print$(z39) 0
  }

  no$(z39)() {
  ## Logical "no"
    
    print$(z39) 20211201
  }

  s39() {
  ## This function doesn't have $(z39) name postfix by purpose. It itself is used as 
  # a name postfix for folding/unfolding blocks of code in an editor.
  # In bigger files it can be handy to user editor folding/unfolding feature for blocks of code
  # For that a function that contains just declaration of other functions is used – a so called grouping-function
  # Each grouping-function has a name with the following prefix
  # 
  # E. g.
  # ```
  # backend$(s39)() { # the start of a folding area
  #     # ... some code probably related to the backend
  # }; _callAndForget_functions backend$(s39) # the end of the folding area
  # ```

    local e=${?}
    print "__zsfScope" 
    return ${e}
  }

  error$(z39)() {
  ## General error
    
    print$(z39) 20220516
  }

  useWithCaution() {
    local e=${?}
    print "__useWithCaution"
    return ${e}
  }

  isShellSupported() {
    [ -z "${ZSH_NAME}" ] && return 1 || return 0
  }

  abortBecauseOf-reason-timeoutSec$(z39)() {
    print "${1}\nKILLING this process in ${2} seconds"
    sleep ${2}
    exitAndKillProcess$(z39)
  }

  isExecutedFromAnotherScript() {
    isEmpty-string$(z39) ${funcstack[3]} && return $(no$(z39)) || return $(yes$(z39))
  }

  exitAndKillProcess$(z39)() {
    exit 1
  }

  userLibraryDir() {
    print$(z39) "$(userHomeDir)/Library"
  }

  userPrefsDir() {
    print$(z39) "$(userLibraryDir)/Preferences"
  }

  userHomeDir() {
    print$(z39) "/Users/$(whoami)"
  }

  userDesktopDir() {
    print$(z39) "$(userHomeDir)/Desktop"
  }

  userAppsDir() {
    print$(z39) "$(userHomeDir)/Applications"
  }

  userTrashDir() {
    print$(z39) "$(userHomeDir)/.Trash"
  }

  edit$(z39)() {
    "${EDITOR}" "${@}"
  }

  tempDir$(z39)() {
    print$(z39) "/Users/$(whoami)/.zZshFramework/temp"
  }
}

_main-zZshFramework-srcDir$(z39) "$(dirname ${0})"  
_unset_functions _main-zZshFramework-srcDir$(z39)