#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

Pods/MockingbirdFramework/mockingbird generate \
    --testbundle "${PRODUCT_NAME}Tests" \
    --targets "$PRODUCT_NAME" \
    --output-dir "$SOURCE_TEST_DIRECTORY"