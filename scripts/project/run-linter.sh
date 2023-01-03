#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Run swiftlint"

$MINT_CMD run realm/SwiftLint@$SWIFTLINT_VERSION swiftlint

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Done run swiftlint"