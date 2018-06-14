                          insane_alias=0
                          case $__arg in
                            # Issue #263: aliases with '=' on their LHS.
                            #
                            # There are three cases:
                            #
                            # - Unsupported, breaks 'alias -L' output, but invokable:
                            ('='*) :;;
                            # - Unsupported, not invokable:
                            (*'='*) insane_alias=1;;
                            # - The common case:
                            (*) :;;
                          esac
                          if (( insane_alias )); then
                            __style=${FAST_THEME_NAME}unknown-token
                          else
                            __style=${FAST_THEME_NAME}alias
                            zmodload -e zsh/parameter && alias_target=${aliases[$__arg]} || alias_target="${"$(alias -- $__arg)"#*=}"
                            [[ ${__FAST_HIGHLIGHT_TOKEN_TYPES[$alias_target]} = "1" && "$__arg_type" != "1" ]] && __FAST_HIGHLIGHT_TOKEN_TYPES[$__arg]="1"
                          fi
