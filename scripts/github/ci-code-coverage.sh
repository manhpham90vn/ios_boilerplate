#!/bin/sh

export BUNDLER_CMD=bundle

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../slather/slather-cmd.sh

$BUNDLER_CMD exec $SLATHER_CMD coverage