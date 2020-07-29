# Passes `shellcheck --shell sh`.
# Tested in bash 3.2, bash 4.4, zsh 5.3, and zsh 5.8.

set_shortened_pwd() {
    __SHORTEN_LENGTH_LIMIT="${1:-1000}"
    SHORTENED_PWD="$PWD"

    # Parse PWD into prefix, dirname, and basename parts.
    # Abbreviate HOME with ~.
    __SHORTEN_TILDE=''
    __SHORTEN_SLASH=''
    __SHORTEN_DIRNAME=''
    __SHORTEN_BASENAME=''
    if test "$PWD" = "$HOME"; then
        __SHORTEN_TILDE='~'
    else
        __SHORTEN_SLASH='/'
        __SHORTEN_UNPREFIXED="${PWD#$HOME/}"
        if test "$PWD" != "$__SHORTEN_UNPREFIXED"; then
            __SHORTEN_TILDE='~'
        else
            __SHORTEN_UNPREFIXED="${PWD#/}"
        fi
        __SHORTEN_BASENAME="${__SHORTEN_UNPREFIXED##*/}"
        __SHORTEN_DIRNAME="${__SHORTEN_UNPREFIXED%$__SHORTEN_BASENAME}"
    fi
    SHORTENED_PWD="${__SHORTEN_TILDE}${__SHORTEN_SLASH}${__SHORTEN_DIRNAME}${__SHORTEN_BASENAME}"
    test ${#SHORTENED_PWD} -le "$__SHORTEN_LENGTH_LIMIT" && return

    # Abbreviate each directory from the left until the accumulated result is
    # within the length limit.
    __SHORTEN_ABBREVIATED=''
    __SHORTEN_DIRECTORY=''
    while test ${#__SHORTEN_DIRNAME} -gt 0; do
        __SHORTEN_DIRECTORY="${__SHORTEN_DIRNAME%%/*}"
        __SHORTEN_DIRNAME="${__SHORTEN_DIRNAME#*/}"
        test ${#__SHORTEN_DIRECTORY} -gt 2 && __SHORTEN_DIRECTORY="${__SHORTEN_DIRECTORY%${__SHORTEN_DIRECTORY#?}}…"
        __SHORTEN_ABBREVIATED="${__SHORTEN_ABBREVIATED}${__SHORTEN_DIRECTORY}/"
        SHORTENED_PWD="${__SHORTEN_TILDE}/${__SHORTEN_ABBREVIATED}${__SHORTEN_DIRNAME}${__SHORTEN_BASENAME}"
        test ${#SHORTENED_PWD} -le "$__SHORTEN_LENGTH_LIMIT" && return
    done

    # Abbreviate the entire dirname.
    SHORTENED_PWD="${__SHORTEN_TILDE}${__SHORTEN_SLASH}…/${__SHORTEN_BASENAME}"
    test ${#SHORTENED_PWD} -le "$__SHORTEN_LENGTH_LIMIT" && return

    # Trim basename from the left until it's within the length limit.
    SHORTENED_PWD="$__SHORTEN_BASENAME"
    __SHORTEN_LENGTH="${#SHORTENED_PWD}"
    while test "$__SHORTEN_LENGTH" -ge 1; do
        test "$__SHORTEN_LENGTH" -le "$__SHORTEN_LENGTH_LIMIT" && return
        SHORTENED_PWD="${SHORTENED_PWD%??}…"
        __SHORTEN_LENGTH="${#SHORTENED_PWD}"
    done

    # At this point, PWD couldn't be shortened for some reason.
    SHORTENED_PWD="$PWD"
}


__shorten_test_case() (
    PWD="$1"
    set_shortened_pwd "$2"
    if test "$SHORTENED_PWD" != "$3"; then
        printf "\e[31mFAIL:\e[0m 'set_shortened_pwd %s' in %s produced %s, expected %s\n" \
            "$2" "$PWD" "$SHORTENED_PWD" "$3"
    else
        printf "\e[32mPASS:\e[0m 'set_shortened_pwd %s' in %s produced %s\n" \
            "$2" "$PWD" "$SHORTENED_PWD"
    fi
)


__shorten_test() {
    __shorten_test_case '/' 1000 '/'
    __shorten_test_case '/' 1 '/'
    __shorten_test_case '/ant/b/cat/d/elephant' 1000 '/ant/b/cat/d/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 21 '/ant/b/cat/d/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 20 '/a…/b/cat/d/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 19 '/a…/b/c…/d/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 18 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 17 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 16 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 15 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 14 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 13 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 12 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 11 '/…/elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 10 'elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 9 'elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 8 'elephant'
    __shorten_test_case '/ant/b/cat/d/elephant' 7 'elepha…'
    __shorten_test_case '/ant/b/cat/d/elephant' 6 'eleph…'
    __shorten_test_case '/ant/b/cat/d/elephant' 5 'elep…'
    __shorten_test_case '/ant/b/cat/d/elephant' 4 'ele…'
    __shorten_test_case '/ant/b/cat/d/elephant' 3 'el…'
    __shorten_test_case '/ant/b/cat/d/elephant' 2 'e…'
    __shorten_test_case '/ant/b/cat/d/elephant' 1 '…'

    (
        export HOME='/Users/foo'
        __shorten_test_case "$HOME" 1000 '~'
        __shorten_test_case "$HOME" 1 '~'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 1000 '~/ant/b/cat/d/elephant'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 22 '~/ant/b/cat/d/elephant'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 21 '~/a…/b/cat/d/elephant'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 20 '~/a…/b/c…/d/elephant'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 19 '~/…/elephant'
        # shellcheck disable=SC2088
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 12 '~/…/elephant'
        __shorten_test_case "$HOME/ant/b/cat/d/elephant" 11 'elephant'
    )
}
