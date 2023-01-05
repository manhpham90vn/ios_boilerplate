#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/swiftgen-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Generate swiftgen"

$MINT_CMD run SwiftGen/SwiftGen@$SWIFTGEN_VERSION $SWIFTGEN_CMD

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Done generate swiftgen"