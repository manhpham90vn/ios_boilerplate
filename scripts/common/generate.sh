#!/bin/sh

pod install

xcodegen generate --spec project.yml

rm -rf Sources/Resources/Generated/*
mkdir -p Sources/Resources/Generated/SwiftGen
swiftgen

mockolo -s Sources -d SourcesTests/Mocks.swift --enable-args-history --mock-all --use-mock-observable --exclude-imports AppKit --testable-imports MyProduct