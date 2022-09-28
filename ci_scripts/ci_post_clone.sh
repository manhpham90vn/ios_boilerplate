#!/bin/sh

bash scripts/installDependencies.sh
mkdir -p Sources/Common/Resources/Generated/SwiftGen
swiftgen
xcodegen generate --spec project.yml
pod install --repo-update