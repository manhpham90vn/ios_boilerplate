#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/brew-cmd.sh

if ! $BREW_CMD --version &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi