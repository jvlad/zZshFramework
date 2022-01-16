#!/usr/bin/env zsh

_main_gitLog() {  

    gitLog_args() {
        git log --pretty=fuller $@
    }
    alias gl="gitLog_args --name-status"
    alias glg="gitLog_args --graph --decorate --name-status"
    alias glga="gitLog_args --all --graph --decorate --name-status"
    alias grl="git reflog"
    
    gitLog_upToCommit_numberOfCommits() {
        local args=${@:3}  
        _gitLogExtract_logRetrieverFunc_upToCommit_numberOfCommits_prefix_postfix \
            gitLogToConsole "$1" "$2" \
                "\`\`\`\n  " \
                "\n\`\`\`  " \
                "$args"
    }

    gitLogShort_upToCommit_numberOfCommits() {
        _gitLogExtract_logRetrieverFunc_upToCommit_numberOfCommits_prefix_postfix \
            gitLogShortToConsole "$1" "$2"
    }
    alias glsc="gitLogShort_upToCommit_numberOfCommits"

    gitLogHeadline_upToCommit_numberOfCommits() {
        _gitLogExtract_logRetrieverFunc_upToCommit_numberOfCommits_prefix_postfix \
            gitLogHeadlineToConsole "$1" "$2"
    }

    gitLogHeadline_startingFromCommit() {
        if isEmpty_String__i $1 ;then
            print-errorMessage$(zsf)__i "Missing 1st Argument – the hash of starting-point commit"
            return 1;
        fi
        gitLogHeadline "$1"^1..
    }
    alias glha="gitLogHeadline_startingFromCommit"

    gitLogHeadlineToConsole_startingFromCommit() {
        gitLogHeadline_startingFromCommit $@ | trimEndSpaces__i
    }
    alias glhca="gitLogHeadlineToConsole_startingFromCommit"

    gitLogHeadline() {
        gitLog_format_args "* %s" $@
    }

    gitLogHeadlineToConsole() {
        gitLogHeadline $@ | trimEndSpaces__i
    }

    gitLogShortCopyToClipboard_commit() {
        gitLogCopyToClipboard_logRetrieverFunc_commit "gitLogShort_commit" "$1"
    }
    alias glscp="gitLogShortCopyToClipboard_commit"

    gitLogCopyToClipboard_commit() {
        gitLogCopyToClipboard_logRetrieverFunc_commit "gitLog_commit" "$1"
    }
    alias glcp="gitLogCopyToClipboard_commit"

    gitLogCopyToClipboard_logRetrieverFunc_commit() {
        copyToClipboard_args__i "$("$1" "$2")"

        isEmpty_String__i "$2" \
            && local feedbackMessage="Most recent commit info copied to clipboard" \
            || local feedbackMessage="$2 commit info copied to clipboard"

        printSuccessAdding_text__i "$feedbackMessage"
    }

    gitCopyToClipboardInfoOfCommit_howManyCommitsAgo() {
        copyToClipboard_args__i $(gitLogCommit_howManyCommitsAgo $1)
    }

    gitLogCommit_howManyCommitsAgo() {
        gitLog_upToCommit_numberOfCommits "HEAD^$1" 1
    }

    gitLog_commit() {
        gitLog_upToCommit_numberOfCommits "$1" 1
    }

    gitLogShort_commit() {
        gitLogShort_upToCommit_numberOfCommits "$1" 1
    }

    gitLogLatestCommits_count() {
        local args=${@:2} 
        gitLog_upToCommit_numberOfCommits HEAD "$1" "$args"
    }
    alias glc="gitLogLatestCommits_count"

    gitLogShortLatestCommits_count() {
        gitLogShort_upToCommit_numberOfCommits HEAD "$1"
    }
    alias glslc="gitLogShortLatestCommits_count"

    gitLogHeadlineLatestCommits_count() {
        gitLogHeadline_upToCommit_numberOfCommits HEAD "$1"
    }
    alias glhlc="gitLogHeadlineLatestCommits_count"

    gitLogLatestCommit() {
        gitLogLatestCommits_count 1 \-\-stat
    }
    alias gll="gitLogLatestCommit"

    gitLogShortToConsole_fromCommit() {
        gitLogShort_startingFromCommit $@ | trimEndSpaces__i
    }
    alias glsca="gitLogShortToConsole_fromCommit" # 'a' stays for 'after'

    gitLogShort_startingFromCommit() {
        if isEmpty_String__i $1 ;then
            print-errorMessage$(zsf)__i "Missing 1st Argument – the hash of starting-point commit"
            return 1;
        fi
        gitLogShort "$1"^1..
    }
    alias glsa="gitLogShort_startingFromCommit" # 'a' stays for 'after'

    gitLogToConsole() {
        gitLog_args $@ | trimEndSpaces__i
    }

    gitLogShortToConsole() {
        gitLogShort $@ | trimEndSpaces__i
    }

    gitLogShort() {
        local repo_top_level=$(git rev-parse --show-toplevel)
        local repo_name=$(basename $repo_top_level)
        gitLog_format_args "%h  %ad $repo_name  %s" $@
    }
    alias gls="gitLogShort"

    gitLog_format_args() {
        # debugFunc:Args_array "$@"
        # %h = abbreviated commit hash
        # %x09 = tab (character for code 9)
        # %an = author name
        # %ad = author date (format respects --date= option)
        # %s = subject
        
        # %a – short day of week
        # %b - short month
        gitLog_args --decorate --pretty=format:"$1" --date=format:%H:%M\ %a\ %b\ %d\ %Y ${@:2}
    }

    _gitLogExtract_logRetrieverFunc_upToCommit_numberOfCommits_prefix_postfix() {
        # debugFunc:Args_array "$@"
        local args=${@:6}  
        local gitLogExtract=$($1 -"$3" "$args" "$2")
        if isEmpty_String__i "$3" ;then
            local gitLogExtract=$($1 "$args" "$2")
        else
            local gitLogExtract=$($1 -"$3" "$args" "$2")
        fi
        isEmpty_String__i $gitLogExtract \
            && return 1 \
            || print__i "$4$gitLogExtract$5" | trimEndSpaces__i
    }

    gitLogWithMessagesContain_Text() {
        gitLogToConsole --all --graph --decorate --name-status -i --grep="$1" 
    } 

    gitLogShortGraphWithMessagesContain_Text() {
        gitLogToConsole --all --graph --decorate --oneline -i --grep="$1"  
    }

    gitLogShortWithMessagesContain_Text() {
        gitLogToConsole log --all --oneline -i --grep="$1"  
    }

    #import
    copyToClipboard_args__i() { sysClipboardCopy:Arg_array $@; }
    print-errorMessage$(zsf)__i() { print-errorMessage$(zsf) $@; }
    isEmpty_String__i() { isEmpty:String $@; }
    printSuccessAdding_text__i() { print-successMessage$(zsf) $@; }
    print__i() { print$(zsf) $@; }
    trimEndSpaces__i() { trimEndSpaces $@; }
}
_callAndForget_functions _main_gitLog  