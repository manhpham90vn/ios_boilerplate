#!/bin/sh

echo 'export GEM_CMD=gem' >> "$BASH_ENV"
echo 'export BUNDLER_CMD=bundler' >> "$BASH_ENV"
source "$BASH_ENV"

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh