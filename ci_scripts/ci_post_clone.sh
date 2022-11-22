#!/bin/sh

cd $CI_WORKSPACE
HOMEBREW_NO_AUTO_UPDATE=1

if ! rbenv -v &> /dev/null
then
    brew install rbenv
fi

if ! mint version &> /dev/null
then
    brew install mint
fi

if ! pod --version &> /dev/null
then
    brew install cocoapods
fi

mint bootstrap --link

rm -rf Sources/Common/Resources/Generated/*
mkdir -p Sources/Common/Resources/Generated/SwiftGen
mint run SwiftGen/SwiftGen@6.5.1 swiftgen

mint run yonaskolb/xcodegen@2.32.0 xcodegen generate --spec project.yml

pod install