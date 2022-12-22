#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

mint run yonaskolb/xcodegen@$XCODEGEN_VERSION xcodegen generate --spec project.yml