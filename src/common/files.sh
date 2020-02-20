#!/usr/bin/env zsh

_main_FilesOperations() {

    userHomeDir(){
        print__zsf "/Users/`whoami`"
    }
    
    fileSizeOf:File() {
        du -sh "$1" 2>/dev/null
    }

    sync_srcDir_targetDir() {
        local srcDir=`fileAbsolutePathOf:File "$1"`
        local targetDir=`fileAbsolutePathOf:File "$2"`
        rsync -r --delete "$srcDir/" "$targetDir/"
    }

    sync_srcRepoDir_targetRepoDir() {
        local srcDir=`fileAbsolutePathOf:File "$1"`
        local targetDir=`fileAbsolutePathOf:File "$2"`
        
        rsync -r --delete --exclude='/.git' \
            --exclude='*.iml' \
            --filter="- .gitignore" \
            "$srcDir/" "$targetDir/"
    }

    fileRefreshSoftLink:LinkPath:TargetFile() {
        del "$1"
        rm "$1"
        ln -s "$2" "$1"
    }

    md5_ofFiles() {
        for item in ${@}; do
            if isDir_path $item ;then
                md5_ofDir "$item"
            else
                md5_ofFile "$item"
            fi
        done
    }
    alias md="md5_ofFiles"

    md5_ofDir() {
        find -s "$1" -type f -exec md5 -q {} \; | md5 -q
    }

    md5_ofFile() {
        md5 -q "$1"
    }

    copyMD5ToClipboard_files() {
        local md5hash=`md5_ofFiles $@`
        sysClipboardCopy:Arg_array "$md5hash" && \
        printSuccessAdding:Message "$md5hash is copied to clipboard"
    }
    alias mdc="copyMD5ToClipboard_files"


    fileCopyPathToClipboard_file(){
        local pathToCopy;
        pathToCopy="`fileAbsolutePathOf:File $1`"
        sysClipboardCopy:Arg_array "$pathToCopy"
        print__zsf "$pathToCopy\nis copied to clipboard"
    }
    alias cl="fileCopyPathToClipboard_file"


    fileSizeOfEachFileIn:Dir() {
        local IFS=$'\n'
        local results=()
        for filename in $1/**; do
            [ -e "$filename" ] || continue
            results+=($(fileSizeOf:File "$filename"))
        done 
        printf '%s\n' ${results[@]} | sort -g
        
        # total run time: 
        # ###### Sat Jun 8 14:30:32 IDT 2019
        # ~4.6s for "/Users/vladzamskoi/Library"
    }

    copyFiles:FromDir:NameMatchingPattern:ToDir() {
        find  "$1" \
            -type f -name "$2" \
            -exec cp '{}' "$3" ';'
    }

    fileName:Path() {
        local absolutePath=`fileAbsolutePathOf:File "$1"`
        local fileName=`fileLastPartOf:Path "$absolutePath"`
        print__zsf "$fileName"
    }

    fileAbsolutePathOf:File() {
        if isPointsToCurrentDir:Path "$1"; then
            print__zsf "`pwd`"
        else
            print__zsf "`realpath "$1"`"
        fi
    }

    isPointsToCurrentDir:Path() {
        if isStringEqualTo:String "$1" "." || isEmpty:String "$1"; then
            return 0;
        else
            return 1;
        fi
    }

    filePrint:Text:ToFile() {
        print__zsf "$1" >> "$2"
    }

    fileCopyPathOfEnclosingDir:RelativePathToFile(){
        local absolutePathToEnclosingDirectory
        if isEmpty:String $1 ;then
            cd ..
            absolutePathToEnclosingDirectory=`systemGetCurrentDirectoryPath`
            cd -
        else
            local relativePathToEnclosingDirectory=`fileBasePartOf:Path "$1"`
            cd "$relativePathToEnclosingDirectory"
            absolutePathToEnclosingDirectory=`systemGetCurrentDirectoryPath`
            cd -
        fi
        sysClipboardCopy:Arg_array "$absolutePathToEnclosingDirectory"
    }
    alias cld="fileCopyPathOfEnclosingDir:RelativePathToFile"

    filePrepareDirWithKeepFileAt:Path() {
        filePrepareDirAt:Path "$1"
        if ! isFileExistAt:Path "$1/.keep" ;then
            fileCreateNewWith:Name "$1/.keep"
        fi
        printSuccessAdding:Message ".keep file is ready at path: $1/.keep"
    }

    filePrepareDirAt:Path() {
        if ! isDir_path "$1" ;then
            print__zsf "Preparing dir at: $1"
            mkdir -p "$1"
        fi
        printSuccessAdding:Message "Directory prepared at path: $1"
    }

    fileCopy:Soruce:ToDestination(){
        cp -r "$1" "$2"
        local fileName=`fileLastPartOf:Path "$1"`
        printSuccessAdding:Message "Copied $fileName -->\n$2"
    }

    fileMoveChangingNameToUnique:SourceFile:Destination(){
        local timeStamp=$(date)
        local uniqueName="${1}_${timeStamp}"
        mv "$1" "$uniqueName"
        mv "$uniqueName" "$2"
        local fileName=`fileLastPartOf:Path "$uniqueName"`
        printSuccessAdding:Message "Moved $fileName -->\n$2"
    }

    fileCreateNewWith:Name(){
        touch "$1"
    }

    fileCreateNewAt:Path:InitialContent() {
        print__zsf "$2" > "$1"
        printSuccessAdding:Message "File created"
    }

    fileMoveToTrashFileAt:Path(){
        local userTrashDir="`userHomeDir`/.Trash"
        for file in "$@"; do
            if isSymlink:File $file; then
                rm "$file"
            elif isFileExistAt:Path $file ;then
                fileMoveChangingNameToUnique:SourceFile:Destination "$file" "$userTrashDir"
            fi
        done
    }
    alias del="fileMoveToTrashFileAt:Path"

    isSymlink:File() {
        test -h "$1"
    }

    fileInsertToBeginning:TextToInsert:FilePath(){
        local originalContent=`cat "$2"`
        print__zsf "$1\n$originalContent" > "$2"
    #    sed -i '' '1i\
    #    \$1
    #    ' "$2"
    }

    cleanDirectoryContent(){
        targetDirectory=$1
        if [[ -z "$targetDirectory" ]]; then
            cleanCurrentDirectory
        else
            clean:Dir $targetDirectory
        fi
    }
    alias cleanDir="cleanDirectoryContent"

    clean:Dir(){
        specifiedDirectory=$1
        fileMoveToTrashFileAt:Path $specifiedDirectory
        mkdir $specifiedDirectory
    }

    cleanCurrentDirectory(){
        targetDirectory=$(pwd)
        cd ..
        fileMoveToTrashFileAt:Path $targetDirectory
        makeDirectoryAndNavigateToIt $targetDirectory
    }

    fileLastPartOf:Path(){
        basename "$1"
    }

    fileBasePartOf:Path(){
        dirname "$1"
    }

    isFileExistAt:Path(){
        if [[ -a $1 ]] ;then
            return 0
        else
            return 1
        fi
    }

    isDir_path() {
        if [[ -d $1 ]] ;then
            return 0
        else
            return 1
        fi
    }
}
_callAndForget_function _main_FilesOperations
