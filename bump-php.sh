#!/bin/sh

if [ ! -z "$1" ]; then
  # make sure we are up to date
  cd ~/aports && git pull

  # we want to abump php7
  echo "Bumping PHP to $1"
  cd ~/aports/main/php7 && abump php7-$1

  # build php7-redis
  cd ~/aports/testing/php7-redis && abuild -r
else
  echo "Usage: $0 7.1.13"
fi
