#!/bin/sh

printf "\033[91mERROR\033[0m: $*\n" 1>&2
exit 1
