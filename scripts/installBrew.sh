#!/usr/bin/env bash
set -e

BREW_CMD="brew"

PACKAGES=(
    rbenv
    xcodegen
    swiftgen
    swiftlint
)

echo "Installing packages..."
$BREW_CMD install ${PACKAGES[@]}

echo "Config PATH..."
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile 
source ~/.bash_profile 

echo "Done"