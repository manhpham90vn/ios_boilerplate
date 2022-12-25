#!/bin/sh

cd $CI_WORKSPACE

export HOMEBREW_NO_AUTO_UPDATE=1
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/ruby/ruby-install.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/mint/mint-run.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/project/generateResource.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/project/generateProject.sh

bundle exec pod install
