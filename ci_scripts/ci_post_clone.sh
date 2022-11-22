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

bundle config path vendor/bundle
bundle install --without=documentation --jobs 4 --retry 3

mint bootstrap --link

rm -rf Sources/Common/Resources/Generated/*
mkdir -p Sources/Common/Resources/Generated/SwiftGen
mint run SwiftGen/SwiftGen@6.5.1 swiftgen

mint run yonaskolb/xcodegen@2.32.0 xcodegen generate --spec project.yml

bundle exec pod install