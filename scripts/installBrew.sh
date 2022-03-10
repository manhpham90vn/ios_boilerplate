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

echo "Config PATH..."
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile 
source ~/.bash_profile 

echo "Done"