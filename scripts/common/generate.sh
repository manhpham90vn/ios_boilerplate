#!/bin/sh

# install pod
pod install

# generate project
xcodegen generate --spec project.yml

# generate swiftgen
rm -rf Sources/Resources/Generated/*
mkdir -p Sources/Resources/Generated/SwiftGen
swiftgen

# generate mock
mockolo -s Sources -d SourcesTests/Mocks.swift --enable-args-history --mock-all --use-mock-observable --exclude-imports AppKit --testable-imports MyProduct