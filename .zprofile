export PATH="$HOME/bin/:$HOME/.cargo/bin/:$PATH"
export EDITOR="`which vim`"

if command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND=fd
fi

profilerc=~/.config/shell/profile-$(hostname).sh
[ -f "$profilerc" ] && source "$profilerc"
