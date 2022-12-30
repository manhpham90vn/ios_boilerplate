#!/bin/sh

cd $CI_WORKSPACE

export HOMEBREW_NO_AUTO_UPDATE=1

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/ruby/ruby-install.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/mint/mint-run.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/project/generate-swiftgen.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/project/generate-project.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../scripts/pod/pod-run.sh
