#!/bin/zsh

source ~/.config/shell/aliases.sh

# Change the title of the terminal to match the current running command.
if [[ $TERM == xterm* ]]; then
    preexec() { print -Pn "\e]2;$1\a" }
    precmd() {
        print -Pn "\e]2;zsh: %~\a"

        # Foot shell integration
        print -Pn "\e]133;A\e\\"
    }
fi

# less(1) colors.
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

# From https://wiki.archlinux.org/title/Color_output_in_console#man
export MANPAGER="less -R --use-color -Dd+r -Du+b"
eval $(dircolors ~/LS_COLORS)

# From https://unix.stackexchange.com/a/273863
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

REPORTTIME=2

# Some of these options are default anyway.
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_BEEP              # Beep when accessing nonexistent history.

setopt CORRECT                # Corrects unmatched external programs.
setopt MENU_COMPLETE          # Correct and autocomplete in the first tab press.
setopt MARK_DIRS              # Adds a trailing / to directories resulting from filename generation.
setopt NO_CLOBBER             # Disables shell redirection to files that already exist. Use >! to force.
setopt GLOB_COMPLETE          # Globs (e.g. *.txt) that have multiple matches use menus.

PROMPT=""
PROMPT+="%B%F{black}"
PROMPT+="%(?.%K{green}.%K{red})"
PROMPT+="$(hostname)"
PROMPT+=":%(5~|%-1~/.../%1~|%4~)"
PROMPT+=" %f%k"
PROMPT+="%F{blue}%K{black}"
PROMPT+=" $ %b%f%k "

# Don't pollute $HOME.
# https://stackoverflow.com/a/71271754
export ZSH_COMPDUMP=$HOME/.cache/zcompdump

# Load the Zsh completion system.
autoload -Uz compinit && compinit -d $ZSH_COMPDUMP

# Modified from https://unix.stackexchange.com/a/214699
# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors "${(s/:/)LS_COLORS}"

# https://stackoverflow.com/a/16149200
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=00}:${(s/:/)LS_COLORS}")'

# Formatting and messages.
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "completing %F{yellow}%B%d%f%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f%b %d"
zstyle ':completion:*:corrections' format '%d %F{red}%B(errors: %e)%f%b'
zstyle ':completion:*' group-name ''

# From zshcompsys(1):
zstyle ':completion:::::' completer _complete _correct _approximate
zstyle ':completion:*:correct:::' max-errors 2 not-numeric
zstyle ':completion:*:approximate:::' max-errors 3 numeric

# Case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# zshzle(1) CHARACTER HIGHLIGHTING
zle_highlight=(isearch:fg=bold,bg=white paste:bg=white suffix:bg=white special:bg=blue)

# Allows us to edit the command line in $EDITOR.
autoload edit-command-line && zle -N edit-command-line

# Duplicate the emacs keymap into `shk', a new keymap. The emacs keymap has nice
# shortcuts, like <Alt>q. See <Alt>xz to see descriptions and the full list of
# mappings.
bindkey -N shk emacs
bindkey -A shk main  # Activate the keymap 'shk'.

bindkey '^[[A' up-line-or-search   # UpArrow
bindkey '^[[B' down-line-or-search # DownArrow
bindkey '^[[1;3C' forward-word     # Alt-RightArrow
bindkey '^[[1;3D' backward-word    # Alt-LeftArrow

bindkey '^[[3~' delete-char # Delete
bindkey '^[[Z' reverse-menu-complete # Shift Tab

bindkey '^X^E' edit-command-line

bindkey -r '^["'

# From https://unix.stackexchange.com/a/319854
backward-kill-dir() {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir # Alt-Backspace

function repeat-history () {
    zle up-history
    zle accept-line
}

zle -N repeat-history
bindkey '^J' repeat-history

# Everything from here is modified code from grml-zsh-config.
declare -A abk
abk=(
    '...'  '../..'
    'eg'   '|& egrep -i --color'
    'l'    '|& less'
    'n'    '>& /dev/null'
)

# Replaces abbreviations.
function zleiab () {
    emulate -L zsh
    setopt interactivecomments
    setopt extendedglob
    local MATCH

    LBUFFER=$(echo "$LBUFFER" | xargs echo)
    LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}
zle -N zleiab

# Shows a list of available abbreviations as help.
function help-show-abk () {
    zle -M "$(print "Available abbreviations for expansion:"; print -a -C 2 ${(kv)abk})"
}
zle -N help-show-abk

# Inserts the actual date in the form yyyy-mm-dd.
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp

# CTRL+.
bindkey '^[[27;5;46~' zleiab
# CTRL+X ,
bindkey '^x,' help-show-abk
# CTRL+X e
bindkey '^Xe' insert-datestamp

# https://github.com/wofr06/lesspipe
command -v lesspipe.sh > /dev/null && eval "$(lesspipe.sh)"
