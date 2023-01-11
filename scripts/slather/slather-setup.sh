#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/config.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

SLATHER_FILE=.slather.yml
OUTPUT_DIRECTORY=fastlane/reports/code_coverage
BUILD_DIRECTORY=build

rm -rf $SLATHER_FILE

cat <<EOF >>$SLATHER_FILE
coverage_service: "cobertura_xml"
xcodeproj: "$PROJECT_NAME.xcodeproj"
scheme: "$SCHEME"
configuration: "$CONFIGURATION"
source_directory: "$SOURCE_DIRECTORY"
output_directory: "$OUTPUT_DIRECTORY"
build_directory: "$BUILD_DIRECTORY"
binary_basename: "$PRODUCT_NAME"
ignore:
  - $SOURCE_DIRECTORY/Common/Resources/*
EOF
