#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

mint run yonaskolb/xcodegen@2.33.0 xcodegen generate --spec project.yml