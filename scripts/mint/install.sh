#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

if ! mint version &> /dev/null
then
    brew install mint
fi

mint bootstrap -m Mintfile --link

export PATH=$PATH:$(pwd)/Mints/bin