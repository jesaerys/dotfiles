# If /usr/local/bin isn't in PATH, then perhaps /etc/profile hasn't been
# sourced (as is the case for terminals running in emacs).
if [[ ${PATH/\/usr\/local\/bin:} = $PATH ]]; then
    source /etc/profile
fi


set -o vi
shopt -s extglob


promptCommand() {
    local BOLD='\[\e[1m\]'
    local RESET='\[\e[0m\]'
    local BLUE='\[\e[38;2;66;122;179m\]'
    local ORANGE='\[\e[38;2;236;109;21m\]'

    local CWD="${PWD##*/}"

    local NIX_ENV="${IN_NIX_SHELL:+(nix-shell) }"
    local CONDA_ENV="${CONDA_DEFAULT_ENV:+(${CONDA_DEFAULT_ENV##*/}) }"
    local PYTHON_VIRTUAL_ENV="${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/}) }"

    local PROMPT_COLOR="$BLUE"
    local OLDIFS="$IFS" X=''; IFS=$'\n'; for X in $(jobs); do
        PROMPT_COLOR="$ORANGE" && break
    done; IFS="$OLDIFS"

    export PS1="${NIX_ENV}${CONDA_ENV}${PYTHON_VIRTUAL_ENV}${BOLD}${CWD} ${PROMPT_COLOR}❯${RESET} "
}
#export PROMPT_COMMAND='promptCommand'
export PS1='\[\e[1m\]\W \[\e[38;2;66;122;179m\]❯ \[\e[0m\]'


export CLICOLOR=1
export LSCOLORS='exfxcxdxbxegedabagacad'  # Default according to manpage
# Corresponding value from geoff.greer.fm/lscolors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
alias ll='ls -lF'


alias grep='grep --color=auto'


function title {
    printf "\033]0;$*\007"
}
