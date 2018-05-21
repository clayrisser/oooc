#!/bin/sh

arg="."
if [ -z "$@" ]; then true; else
  arg=$1
  shift
fi

perl $(dirname "$0")/sanitize.pl <&0 | yq "$arg" "$@"
