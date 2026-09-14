# Disable Apple Terminal.app per-session history.
# /etc/zshrc_Apple_Terminal runs before ~/.zshrc and forks HISTFILE per
# terminal session unless this is 0. Must live in ~/.zshenv to take effect
# in time. With SHARE_HISTORY in ~/.zshrc this gives one shared infinite history.
export SHELL_SESSION_HISTORY=0
