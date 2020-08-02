#!/usr/bin/env zsh

# How to enable zZshFramework on Unix based system:  
#
# 1. locate or create `.zhsrc` file at your user home directory 
#
# 2. open .zshrc in any text editor and add to the end:  
#   source "<path/to/this/file>"
#
#   E. g. 
#     source "/Users/JohnDoe/zZshFramework/src/1_zZshFramework_main.sh"
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

_main_1_zZshFramework_main() {

    version__zsf() {
        print "zZshFramework 1.4.7.202000802_zsf_zsh"
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
    
    local d="$zsf_dir"

    source "$d/common/import.sh"
    _import_shFilesPaths \
        "$d/common/clipboard" \
        "$d/common/debug" \
        "$d/common/feedback_printing" \
        "$d/common/files" \
        "$d/common/string_manipulations" \
        "$d/git/git_log" \

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

local zsf_dir="`dirname $0`"
_main_1_zZshFramework_main
_unset_functions _main_1_zZshFramework_main