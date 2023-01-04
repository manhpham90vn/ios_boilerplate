#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/xcodegen-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/xcodegen-config.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Generate xcodegen"

$MINT_CMD run yonaskolb/xcodegen@$XCODEGEN_VERSION $XCODE_GEN_CMD generate --spec $XCODE_GEN_FILE

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done generate xcodegen"