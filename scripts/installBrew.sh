#!/usr/bin/env bash
set -e

BREW_CMD="brew"

PACKAGES=(
    rbenv
    xcodegen
    swiftgen
    swiftlint
)

echo "Starting setup"

if ! [ -e $BREW_CMD ]; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit
fi

echo "Installing packages..."
$BREW_CMD install ${PACKAGES[@]}

echo "Done"