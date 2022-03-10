#!/usr/bin/env bash
set -e

if ! rbenv -v &> /dev/null
then
    brew install rbenv
fi

if ! xcodegen --version &> /dev/null
then
    brew install xcodegen
fi

if ! swiftgen --version &> /dev/null
then
    brew install swiftgen
fi

if ! swiftlint --version &> /dev/null
then
    brew install swiftlint
fi

echo "Done"