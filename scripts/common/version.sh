#!/bin/sh

if [ -z "$XCODEGEN_VERSION" ]; then
    export XCODEGEN_VERSION=2.33.0
fi

if [ -z "$SWIFTGEN_VERSION" ]; then
    export SWIFTGEN_VERSION=6.5.1
fi

if [ -z "$SWIFTLINT_VERSION" ]; then
    export SWIFTLINT_VERSION=0.49.1
fi