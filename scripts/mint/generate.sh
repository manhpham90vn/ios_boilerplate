#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

rm -rf Sources/Common/Resources/Generated/*
mkdir -p Sources/Common/Resources/Generated/SwiftGen

mint run SwiftGen/SwiftGen@6.5.1 swiftgen