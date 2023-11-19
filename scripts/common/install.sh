#!/bin/sh

# install cocoapods
if ! pod --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh cocoapods
fi

# install xcodegen
if ! xcodegen --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh xcodegen
fi

# SwiftGen
if ! swiftgen --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh swiftgen
fi

# swiftlint
if ! swiftlint --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh swiftlint
fi

# mockolo
if ! mockolo --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh mockolo
fi