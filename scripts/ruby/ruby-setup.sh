#!/bin/sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ")

BUNDLER_PATH=vendor/bundle