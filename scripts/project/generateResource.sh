#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

rm -rf Sources/Common/Resources/Generated/*
mkdir -p Sources/Common/Resources/Generated/SwiftGen

$MINT_CMD run SwiftGen/SwiftGen@$SWIFTGEN_VERSION swiftgen