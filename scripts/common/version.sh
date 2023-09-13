#!/bin/sh

if ! [[ $XCODEGEN_VERSION ]];
then
    XCODEGEN_VERSION=2.33.0
fi

if ! [[ $SWIFTGEN_VERSION ]];
then
    SWIFTGEN_VERSION=6.5.1
fi

if ! [[ $SWIFTLINT_VERSION ]];
then
    SWIFTLINT_VERSION=0.52.4
fi

if ! [[ $SMOCK_OLO_VERSION ]];
then
    SMOCK_OLO_VERSION=2.0.1
fi
