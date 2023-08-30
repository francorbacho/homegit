export PATH="$HOME/bin/:$PATH"

profilerc=~/.config/shell/profile-$(hostname).sh
[ -f "$profilerc" ] && source "$profilerc"
