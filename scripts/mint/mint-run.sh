#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mint-install.sh

if ! [ "$(ls -A $MINT_LINK_PATH)" ]
then
    $MINT_CMD bootstrap -m $MINT_FILE --link
fi