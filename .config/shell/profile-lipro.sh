export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM="wayland;xcb"
export LD_LIBRARY_PATH=/usr/lib

export QT_AUTO_SCREEN_SCALE_FACTOR=1.5
export GDK_SCALE=1.5

# https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_VA-API
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi

export BROWSER=/var/lib/flatpak/exports/bin/re.sonny.Junction
export TERMINAL="`which foot`"
