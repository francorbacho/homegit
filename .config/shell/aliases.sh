# 🤭
alias hg='git --git-dir="$HOME/.homegit" --work-tree="$HOME"'
alias rs='source ~/.zshrc'

C=--color=always

alias open=xdg-open
alias ls='ls --color=auto --group-directories-first'
alias rm=" rm"
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias poem="grep -E '^[[:alnum:]]+$' /usr/share/dict/american-english | shuf -n2 | tr '[:upper:]' '[:lower:]' | xargs printf '%s.%s\n'"
alias bc="bc -q"

alias gdb="gdb -q "
alias python="python -q"
alias sudo="sudo "
alias clear="env TERM=xterm clear"

function cdt() {
    dir="/tmp/tmp-$(poem)"
    while [[ -d $dir ]]; do
        dir="/tmp/tmp-$(poem)"
    done

    mkdir $dir
    cd $dir
}

alias diff='diff --unified --color --report-identical-files'

alias mpv="mpv --keep-open=yes"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

function mfs () {
    host=$1

    if ! grep -q $host ~/hosts; then
        echo "$0: No such host '$host'"
        return 1
    fi

    if mountpoint -q "/remote/$host"; then
        echo "$0: Host is already mounted"
        return 0
    fi

    remoteuser=$(ssh $host whoami)
    localuser=$(whoami)

    [ -d /remote/$host ] || sudo sh -c \
        "mkdir -p /remote/$host && chown -R $localuser:$localuser /remote/$host"

    sshfs $host:/home/$remoteuser /remote/$host
}
