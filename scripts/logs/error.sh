#!/bin/sh

echo "\033[91mERROR\033[0m: ${@}" 1>&2
exit 1
