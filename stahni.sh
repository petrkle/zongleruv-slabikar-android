#!/bin/bash

set -e

LC_ALL=C

WGET=${WGET:-wget}

ZSDIR=app/src/main/assets/www

URL=http://localhost:4567

rm -rf $ZSDIR

$WGET \
        -e "robots=off" \
        --verbose \
        --output-file=log.txt \
        --html-extension \
        --no-parent \
        --no-directories \
        --recursive \
        --convert-links \
        --page-requisites \
        --directory-prefix=$ZSDIR \
        --no-host-directories \
        --reject '*.pdf,odkazy.html,mobil.*,navody.html' \
        -X animace/siteswap,animace/en,ulita,navody,download\
        $URL

$WGET \
        --quiet \
        --directory-prefix=$ZSDIR \
        --no-host-directories \
          "$URL`grep svg app/src/main/assets/www/*.js | awk -F '"' '{print $2}'`"
