#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/setup.sh

mint run realm/SwiftLint@$SWIFTLINT_VERSION swiftlint