#!/bin/sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

mkdir -p Mints/{lib,bin}

export MINT_PATH=Mints/lib 
export MINT_LINK_PATH=Mints/bin
export PATH=$PATH:$(pwd)/Mints/bin

cat <<EOF >>Mintfile
yonaskolb/xcodegen@$XCODEGEN_VERSION
SwiftGen/SwiftGen@$SWIFTGEN_VERSION
realm/SwiftLint@$SWIFTLINT_VERSION
EOF

MINT_FILE=Mintfile