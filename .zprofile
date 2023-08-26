export PATH="$PATH:$HOME/bin/"

profilerc=~/.config/shell/profile-$(hostname).sh
[ -f "$profilerc" ] && source "$profilerc"
