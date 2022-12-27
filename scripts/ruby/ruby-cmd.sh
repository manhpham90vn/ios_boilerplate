#!/bin/sh

if [ -z "$GEM_CMD" ]; then
    GEM_CMD=gem
fi

if [ -z "$BUNDLER_CMD" ]; then
    BUNDLER_CMD=bundle
fi

if [ -z "$RBENV_CMD" ]; then
    RBENV_CMD=rbenv
fi

if [ -z "$RUBY_CMD" ]; then
    RUBY_CMD=ruby
fi