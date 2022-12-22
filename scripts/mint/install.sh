#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

if ! mint version &> /dev/null
then
    brew install mint
fi

if ! [ "$(ls -A Mints/bin)" ]
then
    mint bootstrap -m Mintfile --link
fi