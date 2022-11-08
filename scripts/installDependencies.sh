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

echo "Done"