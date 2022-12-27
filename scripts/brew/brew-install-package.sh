#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/brew-install.sh

PACKAGE_NAME=$1

if !($BREW_CMD list $PACKAGE_NAME > /dev/null 2>&1); then
  sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Package $PACKAGE_NAME is not install"
  sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install $PACKAGE_NAME use $BREW_CMD"
  $BREW_CMD install $PACKAGE_NAME
fi