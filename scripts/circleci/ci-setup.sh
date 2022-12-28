#!/bin/sh

export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ")
gem install bundler:$BUNDLER_VERSION

bundle config path vendor/bundle
bundle install --without=documentation --jobs 4 --retry 3