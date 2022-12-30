#!/bin/sh

ls /Applications | grep Xcode

sudo xcode-select -switch /Applications/Xcode_14.0.1.app && /usr/bin/xcodebuild -version