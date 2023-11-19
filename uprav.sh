#!/bin/bash

set -e

ZSDIR=app/src/main/assets/www

for foo in `find $ZSDIR -name '*.html'`;
do
  sed -i 's#http://localhost:4567#https://zonglovani.info#g' $foo
  sed -i 's/zongl\.info/zonglovani.info/g' $foo
  sed -i '/<link rel="manifest/d' $foo
done

php uprav.php

sed '/p:"\//d' $ZSDIR/*.js -i
