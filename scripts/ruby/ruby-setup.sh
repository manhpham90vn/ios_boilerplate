#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-cmd.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

PROJECT_BUNDLER_VERSION=$(cat < Gemfile.lock | tail -1 | tr -d " ")
CURRENT_BUNDLER_VERSION=$($BUNDLER_CMD --version 2>/dev/null | grep -o -E "Bundler version [0-9]+\\.[0-9]+\\.[0-9]+" | cut -d' ' -f3)
BUNDLER_PATH=vendor/bundle
PROJECT_RUBY_VERSION=$(cat $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../.ruby-version)
CURRENT_RUBY_VERSION=$($RUBY_CMD --version 2>/dev/null | grep -o -E "ruby [0-9]+\\.[0-9]+\\.[0-9]+" | cut -d' ' -f2)
RBENV_CONFIG_EXPORT_PATH="export PATH=\"\$HOME/.rbenv/bin:\$PATH\""
RBENV_CONFIG_INIT="eval \"\$(rbenv init -)\""