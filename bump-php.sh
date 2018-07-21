#!/bin/sh

set -ex

# This is to be volume mounted into an alpine docker box for building

if [ $# -ne 1 ]; then
  echo "Usage: $0 7.1.21"
  exit 1
else
  PHPVERSION=$1
fi

sudo chown -R $(whoami) ~/aports 

# make sure we are up to date
cd ~/aports && git checkout 3.7-stable && git pull

# we want to abump php7
echo "Bumping PHP to $PHPVERSION"
cd ~/aports/community/php7 && abump -k php7-$PHPVERSION
