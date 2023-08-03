# 🤭
alias hg='git --git-dir="$HOME/.homegit" --work-tree="$HOME"'

alias open=xdg-open
alias ls='ls --color=auto --group-directories-first'
alias rm=" rm"
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias poem="grep -P '^[[:alnum:]]+$' /usr/share/dict/american-english | shuf -n2 | tr '[:upper:]' '[:lower:]' | xargs printf '%s.%s\n'"
alias bc="bc -q"

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
