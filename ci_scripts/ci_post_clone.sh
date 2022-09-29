#!/bin/sh

cd $CI_WORKSPACE
HOMEBREW_NO_AUTO_UPDATE=1

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

mkdir -p Sources/Common/Resources/Generated/SwiftGen

swiftgen config run --config swiftgen.yml

xcodegen generate --spec project.yml

pod install