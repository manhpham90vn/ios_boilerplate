#!/bin/sh

export GEM_CMD=gem
export BUNDLER_CMD=bundler

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../ruby/ruby-install.sh