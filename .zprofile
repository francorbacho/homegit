export PATH="$HOME/bin/:$HOME/.cargo/bin/:$PATH"
export EDITOR="`which vim`"

profilerc=~/.config/shell/profile-$(hostname).sh
[ -f "$profilerc" ] && source "$profilerc"
