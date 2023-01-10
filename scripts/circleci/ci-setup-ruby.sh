#!/bin/sh

export GEM_CMD=gem

if ! [[ $CI ]];
then
    export CI=true
fi

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh