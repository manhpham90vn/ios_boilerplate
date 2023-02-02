#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mockolo-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Generate mockolo"

$MINT_CMD run uber/mockolo@$SMOCK_OLO_VERSION $MOCK_OLO_CMD -s $SOURCE_DIRECTORY -d $SOURCE_TEST_DIRECTORY/Mocks.swift --enable-args-history --mock-all --use-mock-observable --exclude-imports AppKit --testable-imports $PRODUCT_NAME

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Done generate mockolo"