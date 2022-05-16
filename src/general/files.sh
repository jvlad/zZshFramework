#!/usr/bin/env zsh

_main_FilesOperations() {  

    fileFind_name() {
        find . -name "$1"
    }

    fileFind_name_inDir() {
        find "$2" -name "$1"
    }
    
    fileSizeOf:File() {
        du -sh "$1" 2>/dev/null
    }

    sync_srcDir_targetDir() {
        local srcDir=$(fileAbsolutePathOf:File "$1")
        local targetDir=$(fileAbsolutePathOf:File "$2")
        rsync -r --delete "$srcDir/" "$targetDir/"
    }

    sync_srcRepoDir_targetRepoDir() {
        local srcDir=$(fileAbsolutePathOf:File "$1")
        local targetDir=$(fileAbsolutePathOf:File "$2")
        
        rsync -r --delete --exclude='/.git' \
            --exclude='*.iml' \
            --exclude-from="$srcDir/.gitignore" \
            "$srcDir/" "$targetDir/"
    }

    fileSoftLinkRefresh:LinkPath:TargetFile() {
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
        local md5hash=$(md5_ofFiles $@)
        sysClipboardCopy:Arg_array "$md5hash" && \
        print-successMessage$(zsf) "$md5hash is copied to clipboard"
    }
    alias mdc="copyMD5ToClipboard_files"

    fileCopyPathToClipboard_file() {
        local pathToCopy;
        pathToCopy="$(fileAbsolutePathOf:File $1)"
        sysClipboardCopyVerbose_argsArray "$pathToCopy"
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
        local absolutePath=$(fileAbsolutePathOf:File "$1")
        local fileName=$(fileLastPartOf:Path "$absolutePath")
        print$(zsf) "$fileName"
    }

    fileAbsolutePathOf:File() {
        if isPointsToCurrentDir:Path "$1"; then
            print$(zsf) "$(pwd)"
        else
            print$(zsf) "$(realpath "$1")"
        fi
    }

    isPointsToCurrentDir:Path() {
        isStringEqualTo:String "$1" "." || isEmpty:String "$1" && return 0 || return 1;
    }

    filePrint:Text:ToFile() {
        fileCreateAt_path "$2"
        print$(zsf) "$1" >> "$2"
    }

    fileCopyPathOfEnclosingDir:RelativePathToFile() {
        sysClipboardCopy:Arg_array "$(fileEnclosingDirPath_relativePath $1)"
    }
    alias cld="fileCopyPathOfEnclosingDir:RelativePathToFile"

    fileEnclosingDirPath_relativePath() {
        if isPointsToCurrentDir:Path "$1" ;then
            fileBasePartOf:Path $(fileCurrentDirPath)
        else
            fileBasePartOf:Path "$(fileCurrentDirPath)/$1"
        fi
    }

    fileCurrentDirPath() {
        print$(zsf) $(pwd)
    }

    fileEnclosingDirName_Path() {
        if isPointsToCurrentDir:Path "$1" ;then
            fileName:Path
        else 
            fileLastPartOf:Path $(fileEnclosingDirPath_relativePath "$1")
        fi
    }

    isEnclosingDirNameEqualsTo_name() {
        isStringEqualTo:String $(fileEnclosingDirName_Path) "$1" \
            && return 0 \
            || return 1
    }

    fileCreateAt_path() {
        filePrepareDirAt:Path "$(fileBasePartOf:Path $1)"
        fileCreateNewWith:Name "$1"
    }

    filePrepareDirWithKeepFileAt:Path() {
        filePrepareDirAt:Path "$1"
        local fileName=".keep"
        if ! isFileExistAt:Path "$1/$fileName" ;then
            fileCreateNewWith:Name "$1/$fileName"
        fi
        print-successMessage$(zsf) "$fileName file is ready at path: $1/$fileName"
    }

    filePrepareDirAt:Path() {
        mkdir -p "$1"
    }

    fileOverwrite-source-destination() {
        fileMoveToTrash-filePaths ${2}
        fileCopy-source-destination ${1} ${2}
    }

    fileCopy-source-destination() {
        cp -r "$1" "$2"
        local fileName=$(fileLastPartOf:Path "$1")
        print-successMessage$(zsf) "Copied $fileName -->\n$2"
    }

    fileMoveChangingNameToUnique-filePath-destinationDir() {
        local timeStamp=$(date)
        local uniqueName="${1}_${timeStamp}"
        mv "$1" "$uniqueName"
        mv "$uniqueName" "$2"
        local fileName=$(fileLastPartOf:Path "$uniqueName")
        print-successMessage$(zsf) "Moved $fileName -->\n$2"
    }

    fileCreateNewWith:Name() {
        touch "$1"
    }

    fileCreateNewAt:Path:InitialContent() {
        fileCreateAt_path ${1}
        print$(zsf) "$2" > "$1"
        # print-successMessage$(zsf) "File created"
    }

    fileMoveToTrash-filePaths() {
        local userTrashDir="$(userHomeDir)/.Trash"
        for file in ${@}; do
            if isSymlink:File $file; then
                rm ${file}
            elif isFileExistAt:Path $file ;then
                fileMoveChangingNameToUnique-filePath-destinationDir ${file} ${userTrashDir}
            fi
        done
    }
    alias del="fileMoveToTrash-filePaths"

    isSymlink:File() {
        test -h "$1"
    }

    fileInsertToBeginning:TextToInsert:FilePath() {
        local originalContent=$(cat "$2")
        print$(zsf) "$1\n$originalContent" > "$2"
    #    sed -i '' '1i\
    #    \$1
    #    ' "$2"
    }

    cleanDirectoryContent() {
        targetDirectory=$1
        if [[ -z "$targetDirectory" ]]; then
            cleanCurrentDirectory
        else
            clean:Dir $targetDirectory
        fi
    }
    alias cleanDir="cleanDirectoryContent"

    clean:Dir() {
        specifiedDirectory=$1
        fileMoveToTrash-filePaths $specifiedDirectory
        mkdir $specifiedDirectory
    }

    cleanCurrentDirectory() {
        targetDirectory=$(pwd)
        cd ..
        fileMoveToTrash-filePaths $targetDirectory
        makeDirectoryAndNavigateToIt $targetDirectory
    }

    fileLastPartOf:Path() {
        basename "$1"
    }

    fileBasePartOf:Path() {
        dirname "$1"
    }

    isFileExistAt:Path() {
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
_callAndForget_functions _main_FilesOperations
