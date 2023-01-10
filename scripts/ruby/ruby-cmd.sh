#!/bin/sh

if ! [[ $GEM_CMD ]];
then
    GEM_CMD=~/.rbenv/shims/gem
fi

if ! [[ $BUNDLER_CMD ]];
then
    BUNDLER_CMD=~/.rbenv/shims/bundler
fi

if ! [[ $RBENV_CMD ]];
then
    RBENV_CMD=rbenv
fi

if ! [[ $RUBY_CMD ]];
then
    RUBY_CMD=~/.rbenv/shims/ruby
fi