#!/bin/bash

set -e

WGET=${WGET:-wget}

ZSDIR=app/src/main/assets/www

rm -rf $ZSDIR

$WGET \
        -e "robots=off" \
        --quiet \
        --html-extension \
        --no-parent \
        --no-directories \
        --recursive \
        --convert-links \
        --page-requisites \
        --directory-prefix=$ZSDIR \
        --no-host-directories \
        --reject '*.pdf,odkazy.html,mobil.html,navody.html,jak-odkazovat.html,toolbox.html' \
        -X animace/siteswap,animace/en,ulita,navody,scripts,download,olympiada,mdz,g,valentyn \
        http://localhost:4567/

$WGET \
        --quiet \
        --directory-prefix=$ZSDIR \
        --no-host-directories \
          "http://localhost:4567`grep svg app/src/main/assets/www/*.js | awk -F '"' '{print $2}'`"
