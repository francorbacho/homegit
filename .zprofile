export PATH="$HOME/bin/:$HOME/.cargo/bin/:$PATH"

profilerc=~/.config/shell/profile-$(hostname).sh
[ -f "$profilerc" ] && source "$profilerc"
