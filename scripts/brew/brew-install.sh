#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/brew-cmd.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

if ! $BREW_CMD --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "$BREW_CMD is not install"
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install $BREW_CMD"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi