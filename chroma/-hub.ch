# vim:ft=zsh:et:sw=4
(( next_word = 2 | 8192 ))
local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"

if (( __first_call )); then
    chroma/-git.ch $*
    return 1
fi
[[ "$__arg_type" = 3 ]] && return 2

if (( FAST_HIGHLIGHT[chroma-git-got-subcommand] == 0 )) && [[ "$__wrd" = "browse" \
    || "$__wrd" = "ci-status" \
    || "$__wrd" = "compare" \
    || "$__wrd" = "create" \
    || "$__wrd" = "delete" \
    || "$__wrd" = "fork" \
    || "$__wrd" = "issue" \
    || "$__wrd" = "pr" \
    || "$__wrd" = "pull-request" \
    || "$__wrd" = "release" \
    || "$__wrd" = "sync" ]]; then
        FAST_HIGHLIGHT[chroma-git-got-subcommand]=1
        FAST_HIGHLIGHT[chroma-git-subcommand]="$__wrd"
        (( __start=__start_pos-${#PREBUFFER}, __end=__end_pos-${#PREBUFFER}, __start >= 0 )) \
            && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}subcommand]}")
        (( FAST_HIGHLIGHT[chroma-git-counter] += 1 ))
        (( this_word = next_word ))
        _start_pos=$4
        return 0
fi

chroma/-git.ch $*
