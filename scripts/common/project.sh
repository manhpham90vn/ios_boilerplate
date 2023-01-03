#!/bin/sh

ENV=sample

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../
cd fastlane

set -a
source .env.$ENV
set +a