#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

if ! bundle --version &> /dev/null
then
    gem install bundler:$BUNDLER_VERSION
fi