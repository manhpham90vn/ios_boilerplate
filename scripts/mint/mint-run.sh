#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mint-install.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

if ! [ "$(ls -A $MINT_LINK_PATH)" ]
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Mint bootstrap use $MINT_FILE"

    $MINT_CMD bootstrap -m $MINT_FILE --link
    
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done mint bootstrap use $MINT_FILE"
fi