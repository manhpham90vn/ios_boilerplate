#!/bin/sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

BUNDLER_VERSION=$(cat < Gemfile.lock | tail -1 | tr -d " ")
BUNDLER_PATH=vendor/bundle
PROJECT_RUBY_VERSION_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../.ruby-version
PROJECT_RUBY_VERSION=$(cat $PROJECT_RUBY_VERSION_PATH)
RBENV_CONFIG_EXPORT_PATH="export PATH=\"\$HOME/.rbenv/bin:\$PATH\""
RBENV_CONFIG_INIT="eval \"\$(rbenv init -)\""