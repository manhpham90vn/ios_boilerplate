#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-cmd.sh

if ! $BUNDLER_CMD exec fastlane version &> /dev/null
then
    source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh
fi

bundle exec fastlane unittest --env debug