#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Generate swiftgen"

rm -rf Sources/Resources/Generated/*
mkdir -p Sources/Resources/Generated/SwiftGen

$MINT_CMD run SwiftGen/SwiftGen@$SWIFTGEN_VERSION swiftgen

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done generate swiftgen"