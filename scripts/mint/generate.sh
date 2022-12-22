#!/bin/sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

rm -rf Sources/Common/Resources/Generated/*
mkdir -p Sources/Common/Resources/Generated/SwiftGen
mint run SwiftGen/SwiftGen@6.5.1 swiftgen

mint run yonaskolb/xcodegen@2.33.0 xcodegen generate --spec project.yml