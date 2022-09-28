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

if ! pod --version &> /dev/null
then
    brew install cocoapods
fi

cd ..

mkdir -p Sources/Common/Resources/Generated/SwiftGen

swiftgen config run --config swiftgen.yml

xcodegen generate --spec project.yml

pod install --repo-update

pwd