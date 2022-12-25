#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-setup.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-cmd.sh

if ! $BUNDLER_CMD --version &> /dev/null
then
    $GEM_CMD install bundler:$BUNDLER_VERSION
fi

$BUNDLER_CMD config path $BUNDLER_PATH
$BUNDLER_CMD install --without=documentation --jobs 4 --retry 3