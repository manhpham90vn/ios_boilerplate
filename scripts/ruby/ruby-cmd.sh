#!/bin/sh

if [ -z "$GEM_CMD" ]; then
    GEM_CMD=~/.rbenv/shims/gem
fi

if [ -z "$BUNDLER_CMD" ]; then
    BUNDLER_CMD=~/.rbenv/shims/bundler
fi

if [ -z "$RBENV_CMD" ]; then
    RBENV_CMD=rbenv
fi

if [ -z "$RUBY_CMD" ]; then
    RUBY_CMD=~/.rbenv/shims/ruby
fi
