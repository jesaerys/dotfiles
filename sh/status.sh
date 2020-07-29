set_status_line() {
    # Build the left side
    __status_left=''

    test "$SHLVL" -gt 1 && __status_left="${__status_left}lvl:${SHLVL} "

    test -n "${IN_NIX_SHELL+x}" && __status_left="${__status_left}nix:${name} "

    test -n "${VIRTUAL_ENV+x}" && __status_left="${__status_left}py:${VIRTUAL_ENV##*/} "

    __status_git_checkout="$(__git_ps1 '%s')"
    test -n "$__status_git_checkout" && __status_left="${__status_left}git:${__status_git_checkout} "


    # Build the right side
    __status_right=''

    __status_job_count="$(jobs | wc -l)"
    test "$__status_job_count" -gt 0 && __status_right="${__status_right} jobs:${__status_job_count}"


    # Build the middle
    __status_length_limit="${1:-${COLUMNS:-$(tput cols)}}"
    if test "$__status_length_limit" -eq -1; then
        SHORTENED_PWD="${PWD##*/}"
    else
        # Measure the remaining length available. This doesn't account for any
        # control sequences, so the result will always be less than or equal to
        # the actual remaining length.
        __status_remaining_length=$(( __status_length_limit - ${#__status_left} - ${#__status_right}))

        # Set the remaining length to 1 if left+right is too long.
        test "$__status_remaining_length" -lt 1 && __status_remaining_length=1

        set_shortened_pwd "$__status_remaining_length"
    fi
    __status_middle="$SHORTENED_PWD" 


    STATUS_LINE="\e[2m${__status_left}${__status_middle}${__status_right}\e[0m"
}


status() {
    set_status_line
    printf "%b\n" "${STATUS_LINE}"
}
