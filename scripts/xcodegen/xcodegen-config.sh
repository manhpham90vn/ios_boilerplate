#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

XCODE_GEN_FILE=project.yml
CONFIGURATION_LOWER=$(echo $CONFIGURATION | tr '[:upper:]' '[:lower:]')