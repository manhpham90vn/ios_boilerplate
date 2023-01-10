#!/bin/sh

if ! [[ $XCODE_GEN_CMD ]];
then
    XCODE_GEN_CMD=xcodegen
fi