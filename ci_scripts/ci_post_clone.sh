#!/bin/sh

cd $CI_WORKSPACE

if ! rbenv --version &> /dev/null
then
    brew install rbenv
    rbenv install 2.6.9
    rbenv global 2.6.9
fi

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/ruby/install.sh

bundle config path vendor/bundle
bundle install --without=documentation --jobs 4 --retry 3

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/mint/install.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/mint/generateResource.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/mint/generateProject.sh

bundle exec pod install