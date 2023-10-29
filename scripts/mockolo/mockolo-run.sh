#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mockolo-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../mint/mint-run.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Generate mockolo"

$MINT_CMD run uber/mockolo@2.0.1 $MOCK_OLO_CMD -s Sources -d SourcesTests/Mocks.swift --enable-args-history --mock-all --use-mock-observable --exclude-imports AppKit --testable-imports MyProduct

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "warning: Done generate mockolo"