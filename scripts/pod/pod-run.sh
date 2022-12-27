#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/pod-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-cmd.sh

if ! $BUNDLER_CMD exec pod --version &> /dev/null
then
    source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh
fi

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install pod"

$BUNDLER_CMD exec $POD_CMD install

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done install pod"