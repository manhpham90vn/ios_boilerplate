#!/usr/bin/env bash
set -e

if ! rbenv -v &> /dev/null
then
    brew install rbenv
fi

if ! mint version &> /dev/null
then
    brew install mint
fi

if ! bundle --version &> /dev/null
then
    export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ")
    gem install bundler
fi

echo "Done"