#!/bin/sh

HOMEBREW_NO_AUTO_UPDATE=1

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../project/generate-resource.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../project/generate-project.sh

bundler exec pod install