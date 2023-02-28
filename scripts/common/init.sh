#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/config.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/version.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../xcodegen/xcodegen-setup.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../swiftgen/swiftgen-setup.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../
cd fastlane

CURRENT_ENV=$(echo $CONFIGURATION | tr '[:upper:]' '[:lower:]')
ENV_FILE=.env.$CURRENT_ENV
rm -rf $ENV_FILE

cat <<EOF >>$ENV_FILE
# Config Project
PROJECT_NAME="$PROJECT_NAME"
XCODEPROJ="\$PROJECT_NAME.xcodeproj"
WORKSPACE="\$PROJECT_NAME.xcworkspace"
SCHEME="$SCHEME"
CONFIGURATION="$CONFIGURATION"
PROVISION_NAME="$PROVISIONING_PROFILE_SPECIFIER"
PATH_XCCONFIG="Sources/Configs/BuildConfigurations/$CONFIGURATION.xcconfig"
UNIT_TEST_DEVICE=$UNIT_TEST_DEVICE

# Common
#FASTLANE_TEAM_ID=""

# Method 1: App Store Connect API key (recommended) - auto testflight versioning
#KEY_ID=""
#ISSUER_ID=""
#KEY_FILEPATH=""

# Method 2: Two-step or two-factor authentication - auto testflight versioning
#FASTLANE_USER=""
#FASTLANE_PASSWORD=""
#FASTLANE_SESSION=""
#FASTLANE_ITC_TEAM_ID=""
#FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=""
#SPACESHIP_2FA_SMS_DEFAULT_PHONE_NUMBER=""

# Method 3: Use altool - not auto testflight versioning
#FASTLANE_USER=""
#FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=""

# Config match
GIT_URL=""
EOF

cd ../Sources/Configs
mkdir -p BuildConfigurations
cd BuildConfigurations
rm -rf ./*

XCCONFIG_FILE_DEBUG=$CONFIGURATION.xcconfig
CONFIGURATION_LOWER=$(echo $CONFIGURATION | tr '[:upper:]' '[:lower:]')

cat <<EOF >>$XCCONFIG_FILE_DEBUG
#include "./Pods/Target Support Files/Pods-$PRODUCT_NAME/Pods-$PRODUCT_NAME.$CONFIGURATION_LOWER.xcconfig"

PRODUCT_NAME = $PRODUCT_NAME
PRODUCT_BUNDLE_IDENTIFIER = $PRODUCT_BUNDLE_IDENTIFIER
BUNDLE_SHORT_VERSION_STRING = $BUNDLE_SHORT_VERSION_STRING
BUNDLE_VERSION = $BUNDLE_VERSION
OTHER_SWIFT_FLAGS = $OTHER_SWIFT_FLAGS
PROVISIONING_PROFILE_SPECIFIER = $PROVISIONING_PROFILE_SPECIFIER
EOF