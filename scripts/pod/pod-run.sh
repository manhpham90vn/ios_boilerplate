#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/pod-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

if ! $BUNDLER_CMD exec pod --version &> /dev/null
then
    $BUNDLER_CMD install
fi