#!/bin/sh

if ! [[ $PROJECT_NAME ]];
then
    PROJECT_NAME=MyProject
fi

if ! [[ $PRODUCT_NAME ]];
then
    PRODUCT_NAME=MyProduct
fi

if ! [[ $SCHEME ]];
then
    SCHEME=MyScheme
fi

if ! [[ $PRODUCT_BUNDLE_IDENTIFIER ]];
then
    PRODUCT_BUNDLE_IDENTIFIER=com.manhpham.myapp.debug
fi

if ! [[ $BUNDLE_SHORT_VERSION_STRING ]];
then
    BUNDLE_SHORT_VERSION_STRING=1.0
fi

if ! [[ $BUNDLE_VERSION ]];
then
    BUNDLE_VERSION=1
fi

if ! [[  $DEPLOYMENT_TARGET ]];
then
    DEPLOYMENT_TARGET=13.0
fi

if ! [[  $SOURCE_DIRECTORY ]];
then
    SOURCE_DIRECTORY=Sources
fi

if ! [[ $SOURCE_TEST_DIRECTORY ]];
then
    SOURCE_TEST_DIRECTORY=SourcesTests
fi

if ! [[ $UNIT_TEST_DEVICE ]];
then
    UNIT_TEST_DEVICE="iPhone 14 Pro Max"
fi

if [[ $IS_PRODUCTION ]];
then
    PROVISIONING_PROFILE_SPECIFIER="match AppStore $PRODUCT_BUNDLE_IDENTIFIER"
    CONFIGURATION=Release
    OTHER_SWIFT_FLAGS="-D RELEASE"
else
    PROVISIONING_PROFILE_SPECIFIER="match Development $PRODUCT_BUNDLE_IDENTIFIER"
    CONFIGURATION=Debug
    OTHER_SWIFT_FLAGS="-D DEBUG"
fi
