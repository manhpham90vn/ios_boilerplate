#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/swiftgen-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Generate swiftgen"

$MINT_CMD run SwiftGen/SwiftGen@6.5.1 $SWIFTGEN_CMD

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Done generate swiftgen"