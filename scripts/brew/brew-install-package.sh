#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/brew-install.sh

PACKAGE_NAME=$1

if !($BREW_CMD list $PACKAGE_NAME > /dev/null 2>&1); then
  $BREW_CMD install $PACKAGE_NAME
fi