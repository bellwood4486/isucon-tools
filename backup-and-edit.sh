#!/usr/bin/env bash

###############################
# How to use
# 1. Download this file into "~/".
# 2. Add alias.
#    $ alias vim='~/backup-and-edit.sh'
# 3. Edit a file.
#    $ vim ~/.bashrc
###############################

set -eu
set -o pipefail

readonly BACKUP_DIR=~/backup
readonly EDITOR=vim

if [[ $# -ne 1 ]]; then
  echo "error: args count must be 1" 1>&2
  exit 1
fi

mkdir -p ${BACKUP_DIR}

if [[ -e $1 ]]; then
  cp "$1" ${BACKUP_DIR}/$(basename "$1").$(date "+%Y%m%d_%H%M%S")
fi

$EDITOR "$1"
