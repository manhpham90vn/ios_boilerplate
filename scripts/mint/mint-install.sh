#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mint-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/mint-setup.sh


if ! $MINT_CMD version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh $MINT_CMD
fi