#!/bin/sh

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

if ! carthage version &> /dev/null
then
    brew install carthage
fi

mkdir -p Sources/Common/Resources/Generated/SwiftGen

swiftgen

xcodegen generate --spec project.yml

pod install --repo-update