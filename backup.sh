#!/usr/bin/env bash

set -eu
set -o pipefail

if [[ $# -ne 1 ]]; then
  echo "error: args count must be 1" 1>&2
  exit 1
fi

cp "$1" "$1.$(date "+%Y%m%d_%H%M%S")"
