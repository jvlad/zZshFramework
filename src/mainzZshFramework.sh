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
    print "__zsf"
}

version$(zsf)() {
    print$(zsf) "zZshFramework 5.3.25.20220515-zsf-zsh"  
}

_main-zZshFramework-srcDir$(zsf)() {
    _initPrivateUtils
    if ! isShellSupported ;then
        abortBecauseOf-reason$(zsf) "Current Shell is NOT supported. Zsh is excepted."  
    fi
    
    local srcDir="${1}"
    local gs="${srcDir}/general"
    source "${gs}/import.sh"
    _import_shFilesPaths \
        "${gs}/inputReader" \
        "${gs}/debug" \
        "${gs}/beta" \
        "${gs}/path" \
        "${gs}/clipboard" \
        "${gs}/printer" \
        "${gs}/files" \
        "${gs}/string_manipulations" \
        "${gs}/networking" \
        "${gs}/docker" \
        "${srcDir}/iOS/iOS_main" \
        "${srcDir}/git/gitLog" \
        "${srcDir}/git/gitHooks" \
        "${srcDir}/git/gitBasic" \
        "${srcDir}/android/android" \
        "${srcDir}/android/macOS-android" \

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
    #* Error code for a general error brough by zZshFramework's logic  
    #*/
    export errorGeneral__zsf=20211201
    export no__zsf=$errorGeneral__zsf

    yes$(zsf)() {
        return 0
    }

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

    print$(zsf)() {
        print "${@}"
    }

    tempDir$(zsf)() {
        print$(zsf) "/Users/$(whoami)/.zShellFramework/temp"
    }
}

_main-zZshFramework-srcDir$(zsf) "$(dirname ${0})"  
_unset_functions _main-zZshFramework-srcDir$(zsf)