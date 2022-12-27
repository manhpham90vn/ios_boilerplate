#!/bin/sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

BUNDLER_VERSION=$(cat < Gemfile.lock | tail -1 | tr -d " ")
BUNDLER_PATH=vendor/bundle
RBENV_CONFIG_EXPORT_PATH="export PATH=\"\$HOME/.rbenv/bin:\$PATH\""
RBENV_CONFIG_INIT="eval \"\$(rbenv init -)\""