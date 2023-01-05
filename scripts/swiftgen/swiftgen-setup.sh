#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/swiftgen-config.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

rm -rf $SWIFTGEN_FILE
rm -rf $SOURCE_DIRECTORY/Resources/Generated/*
mkdir -p $SOURCE_DIRECTORY/Resources/Generated/SwiftGen

cat <<EOF >>$SWIFTGEN_FILE
xcassets:
  inputs:
    - $SOURCE_DIRECTORY/Resources/Assets.xcassets
    - $SOURCE_DIRECTORY/Resources/Colors.xcassets
  outputs:
    - templateName: swift5
      output: $SOURCE_DIRECTORY/Resources/Generated/SwiftGen/Assets.swift
      params:
        forceProvidesNamespaces: true
ib:
  inputs:
    - Sources/Modules
  outputs:
    - templateName: scenes-swift5
      output: $SOURCE_DIRECTORY/Resources/Generated/SwiftGen/StoryboardScenes.swift

EOF