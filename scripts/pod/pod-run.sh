#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/pod-run.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install/pod-run.sh

if ! $BUNDLER_CMD exec pod --version &> /dev/null
then
    $BUNDLER_CMD install
fi