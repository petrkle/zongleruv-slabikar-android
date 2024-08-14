#!/bin/bash

RES=app/src/main/res/mipmap

declare -A icon

icon[48]='mdpi'
icon[72]='hdpi'
icon[96]='xhdpi'
icon[144]='xxhdpi'
icon[192]='xxxhdpi'

for foo in "${!icon[@]}"
do
  for baz in launcher launcher_round
  do
    [ -d ${RES}-${icon[$foo]} ] || mkdir -p ${RES}-${icon[$foo]}
    magick google-play-graphics/hires-icon.png -resize ${foo}x${foo} ${RES}-${icon[$foo]}/ic_${baz}.png
  done
done
