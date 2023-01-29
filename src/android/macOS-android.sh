#!/usr/bin/env zsh

##
# Usually you want the screenshots to be saved to the same dir all the time (e. g. Desktop or Downloads), 
# for this you can into your ~/.zshrc your own warpper like this:  
# ```
# adbScreenshot_name() {
#     adbScreenshot_targetDir_targetFileName "<PATH_TO_YOUR_DESKTOP_DIR>" "$1"
# }
# alias screenshot="adbScreenshot_name"
# ```
# 
# And then use it like: 
# ```
# $: adbScreenshot_name myNewScreenshot
# ```
#
adbScreenshot_targetDir_targetFileName() {
    local filePath="$1/$2"
    local resultFile=$(adbScreenshot_filePath "$filePath")
    sysClipboardCopyVerbose-args "$resultFile"
    open "$resultFile"
}

