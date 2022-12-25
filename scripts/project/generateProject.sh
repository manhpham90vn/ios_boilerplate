#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

$MINT_CMD run yonaskolb/xcodegen@$XCODEGEN_VERSION xcodegen generate --spec project.yml