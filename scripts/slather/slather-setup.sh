#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/project.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

SLATHER_FILE=.slather.yml
SOURCE_DIRECTORY=Sources
OUTPUT_DIRECTORY=xml_report
BUILD_DIRECTORY=build
BINARY_BASENAME="My App Debug"

rm -rf $SLATHER_FILE

cat <<EOF >>$SLATHER_FILE
coverage_service: "cobertura_xml"
xcodeproj: "$XCODEPROJ"
scheme: "$SCHEME"
configuration: "$CONFIGURATION"
source_directory: "$SOURCE_DIRECTORY"
output_directory: "$OUTPUT_DIRECTORY"
build_directory: "$BUILD_DIRECTORY"
binary_basename: "$BINARY_BASENAME"
ignore:
  - $SOURCE_DIRECTORY/Common/Resources/*
EOF