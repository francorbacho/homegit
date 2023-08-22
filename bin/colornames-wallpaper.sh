#!/bin/bash

data=$(curl -s 'https://colornames.org/random/json/')
hexcode=$(echo $data | jq -r '.hexCode')
colorname=$(echo $data | jq -r '.name')
textcolor=$(pastel textcolor $hexcode | pastel format name)
outputfile="/tmp/colors/color-$hexcode.png"

mkdir -p /tmp/colors/
find /tmp/colors/ -amin +30 -type f -delete

magick \
    -size 1920x1200                                    \
    -background "#$hexcode"                            \
    -fill "$textcolor"                                 \
    -font /usr/share/fonts/TTF/OpenSans-ExtraBold.ttf  \
    -pointsize 150                                     \
    caption:"$colorname"                               \
    "$outputfile"

gsettings set org.gnome.desktop.background picture-uri "file://$outputfile"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$outputfile"

echo "$outputfile"
