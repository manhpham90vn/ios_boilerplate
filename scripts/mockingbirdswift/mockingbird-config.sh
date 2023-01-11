#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mockingbird-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

if $MOCKINGBIRD_CMD --version &> /dev/null
then
    $MOCKINGBIRD_CMD configure \
        "${PRODUCT_NAME}Tests" -- \
        --targets "$PRODUCT_NAME"
fi