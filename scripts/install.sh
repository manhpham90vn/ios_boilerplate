#!/bin/sh

if ! mint version &> /dev/null
then
    brew install mint
fi

if ! bundle --version &> /dev/null
then
    gem install bundler:$BUNDLER_VERSION
fi