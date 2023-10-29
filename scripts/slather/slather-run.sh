#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/slather-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-cmd.sh

if ! $BUNDLER_CMD exec $SLATHER_CMD version &> /dev/null
then
    source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh
fi

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Run slather"

$BUNDLER_CMD exec $SLATHER_CMD

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done run slather"