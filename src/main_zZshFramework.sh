#!/usr/bin/env zsh

# How to enable zZshFramework on Unix based system:  
#
# 1. locate or create `.zhsrc` file at your user home directory 
#
# 2. open .zshrc in any text editor and add to the end:  
#   source "<PATH_TO_THIS_FILE_DIR>/main_zZshFramework.sh"
#
#   E. g. 
#     source "/Users/JohnDoe/zZshFramework/src/main_zZshFramework.sh"
#
# 3. Reopen your terminal or relaunch ZSH 
#   Alternatively, run:  
#   source ~/.zshrc
#
# 4. Recheck zZshFramework enabled by running:  
#   version__zsf
#
#   Expected output:  
#       zZshFramework x.x.x.xxxxxxxx
#

_main_zZshFramework_srcDir() {
    export srcDir__zsf="$1"

    version__zsf() {
        print "zZshFramework 2.1.8.202000814_zsf_zsh"
    }

    edit__zsf() {
        "$EDITOR" "$@"
    }

    print__zsf() {
        print "$@"
    }

    tempDir__zsf() {
        print__zsf "/Users/`whoami`/.zShellFramework/temp"
    }

    userLibraryDir() {
        print "`userHomeDir`/Library"
    }

    userPrefsDir() {
        print "`userLibraryDir`/Preferences"
    }

    userDesktopDir() {
        print "`userHomeDir`/Desktop"
    }

    userAppsDir(){
        print "`userHomeDir`/Applications"
    }
    
    source "$srcDir__zsf/common/import.sh"
    _import_shFilesPaths \
        "$srcDir__zsf/common/clipboard" \
        "$srcDir__zsf/common/debug" \
        "$srcDir__zsf/common/feedback_printing" \
        "$srcDir__zsf/common/files" \
        "$srcDir__zsf/common/android" \
        "$srcDir__zsf/common/string_manipulations" \
        "$srcDir__zsf/git/gitLog" \
        "$srcDir__zsf/git/gitHooks" \


}

if [ -z "$ZSH_NAME" ] ;then
    printf "ERROR: Unsupported shell. Please use z-shell, aka ZSH.\n\
The easiest way to install zsh on MacOS is to run:
brew install zsh

Then run zsh and from there run 
source <PATH_TO_THIS_SCRIPT>

If you don't have brew, check https://brew.sh/

"
    return 1
fi

_main_zZshFramework_srcDir "`dirname $0`"  
_unset_functions _main_zZshFramework_srcDir  
