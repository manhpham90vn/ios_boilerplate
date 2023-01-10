#!/bin/sh

export GEM_CMD=gem

if ! [[ $SKIP_RUN ]];
then
    export SKIP_RUN=true
fi

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh